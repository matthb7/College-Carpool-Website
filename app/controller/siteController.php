<?php
include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a SiteController and route it
$pc = new SiteController();
$pc->route($action);

class SiteController {
	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'home':
				$this->home();
				break;
			case 'signup':
				$this->signup();
				break;
			case 'login':
				$this->login();
				break;
			case 'follow':
				$userID = $_GET['pid'];
				$this->follow($userID);
				break;
			case 'logout':
				$this->logout();
				break;
			case 'register':
				$fn = $_POST['fn'];
				$ln = $_POST['ln'];
				$em = $_POST['em'];
				$un = $_POST['un'];
				$pw = $_POST['pw'];
                $role = $_POST['role'];
				$this->register($fn, $ln, $em, $un, $pw, $role);
				break;
			case 'processLogin':
				$username = $_POST['un'];
				$password = $_POST['pw'];
				$this->processLogin($username, $password);
				break;
            case 'profile':
                $this->profile();
                break;
            case 'editProfile':
                $fn = $_POST['fn'];
                $ln = $_POST['ln'];
                $em = $_POST['em'];
                $role = $_POST['role'];
                $this->editProfile($fn, $ln, $em, $role);
                break;
            case 'editPW':
                $nPW = $_POST['nPW'];
                $this->editPW($nPW);
                break;
			// redirect to home page if all else fails
		   	default:
		        header('Location: '.BASE_URL);
		        exit();
		}
	}

	//Switch to the Home View
  	public function home() {
			$pageName = 'Home';
			include_once SYSTEM_PATH.'/view/header.tpl';
			if(isset($_SESSION['user']))
			{
				$pageName = 'Activity Feed';
                $products = Product::getAllProducts();
				$myID = $_SESSION['id'];
                $user = User::loadById($myID);
                $array;
                if ($user != null) {
                    if ($user->get('following') == "") {
                        $array = array();
                    }
                    else {
                        $array = unserialize($user->get('following'));
                    }
                }
				include_once SYSTEM_PATH.'/view/feed.tpl';
			}
			else
			{
				include_once SYSTEM_PATH.'/view/home.tpl';
			}
			include_once SYSTEM_PATH.'/view/footer.tpl';
  	}

  	//Switch to the Sign Up View
	public function signup() {
		$pageName = 'Sign Up';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/signup.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  	}

  	//Switch to the Login View
	public function login() {
		$pageName = 'Login';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/login.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  	}

  	//Logout, Destroy Current Session
  	public function logout() {
		//session_start();
		session_destroy();

		header('Location: '.BASE_URL);
		exit();
  	}

  	//Insert New User Data to the User Database
  	public function register($fn, $ln, $em, $un, $pw, $role) {
        $user = new User();
        $user->set('first_name', $fn);
        $user->set('last_name', $fn);
        $user->set('pw', $pw);
        $user->set('role', $role);
        $user->set('username', $un);
        $user->save();
		$_SESSION['user'] = $un;
		$_SESSION['role'] = $role;

        $newUser = User::loadByUsername($un);
        $_SESSION['id'] = $newUser->get('id');
		header('Location: '.BASE_URL);
		exit();
  	}

	//follow or unfollow a user
	public function follow($id){

		if(isset($_SESSION['id']))
		{
			$myID = $_SESSION['id'];
            $user = User::loadById($myID);
            if ($user != null) {
				//$followOrRemove = 1;
				$profile = User::loadByUsername($_SESSION['user']);
				if($profile->get('following') == "") //array hasn't been made yet
				{
					$array = array($id);

					$_SESSION['follow'] = 1;
					$profile->set('following', serialize($array));
					$profile->save();
				}
				else{ //array already exists

					$array = unserialize($profile->get('following'));
					$num = count($array);
					if(count(array_diff($array, array($id))) == $num) //add to array
					{
						$_SESSION['follow'] = 1;
						array_push($array, $id);
						$profile->set('following', serialize($array));
						$profile->save();
					}
					else{//remove
						$_SESSION['unfollow'] = 1;
						$newarray =array();
						$i = 0;
						for ($x = 0; $x < count($array); $x++) {
							if($array[$x] != $id && $array[$x] != NULL)
							{
								array_push($newarray, $array[$x]);
							}
						}
						$followOrRemove = 0;
						$profile->set('following', serialize($newarray));
						$profile->save();
					}
				}
			}

			header('Location: ' . $_SERVER['HTTP_REFERER']);
		}
	}


  	//Attempt to Login with Credentials, Check if Credentials Match the User Database
	public function processLogin($u, $p) {
		$adminUsername = 'foo';
		$adminPassword = 'bar';
		if (($u == $adminUsername) && ($p == $adminPassword)) {
			$_SESSION['user'] = "ADMIN";
			$_SESSION['id'] = 7;
            $_SESSION['role'] = 'd';
		}
		else {
            $user = User::loadByUsername($u);
            if ($user->get('pw') == $p) {
                $_SESSION['user'] = $user->get('username');
            	$_SESSION['id'] = $user->get('id');
                $_SESSION['role'] = $user->get('role');
            }
			else {
				$_SESSION['err'] = 'Invalid Credentials';
				header('Location: '.BASE_URL.'/login/');
				exit();
			}
		}

		header('Location: '.BASE_URL);
		exit();
	}

    public function profile() {
        $pageName = 'My Profile';
        $profile = User::loadByUsername($_SESSION['user']);
        $products = Product::getAllUsersRides($_SESSION['id']);
        $allProducts = Product::getAllProducts();
        include_once SYSTEM_PATH.'/view/header.tpl';
		$array;
        if ($profile != null) {
			if($profile->get('following') == "") {
				$array = array();
			}
			else {
				$array = unserialize($profile->get('following'));
			}
        }

        include_once SYSTEM_PATH.'/view/profile.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

    public function editProfile($fn, $ln, $em, $role) {
        //Get user to edit from DB
        $profile = User::loadByUsername($_SESSION['user']);
        //Set and save
        $profile->set('first_name', $fn);
        $profile->set('last_name', $ln);
        $profile->set('email', $em);
        $profile->set('role', $role);
        $profile->save();
        //Notify user of changes
        $_SESSION['role'] = $role;
        $_SESSION['editMessage'] = 'Profile Updated';
        //Return to profile page
        header('Location: '.BASE_URL.'/profile/');
    }

    public function editPW($nPW) {
        $profile = User::loadByUsername($_SESSION['user']);
        $profile->set('pw', $nPW);
        $profile->save();
        //Notify of changes
        $_SESSION['editMessage'] = 'Password Updated';
        //Return to profile page
        header('Location: '.BASE_URL.'/profile/');
    }
}
