<?php
include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a ProductController and route it
$pc = new ProductController();
$pc->route($action);

class ProductController {
	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'viewList':
		        $this->viewList();
				break;
			case 'viewProduct':
        		$productID = $_GET['pid'];
				$this->viewProduct($productID);
				break;
			case 'back':
        		$this->back();
        		break;
			case 'editProduct':
        		$productID = $_GET['pid'];
				$this->editProduct($productID);
				break;
			case 'saveChanges':
        		$productID = $_GET['pid'];
        		$name = $_POST['name'];
				$description = $_POST['description'];
				$destination = $_POST['destination'];
				$source = $_POST['source'];
				$leave_time = $_POST['leave_time'];
				$price = $_POST['price'];
				$url = $_POST['url'];
				if ($url == '') {
	    			$url = 'user-default.png';
	    		}
        		$this->saveChanges($productID, $name, $description, $destination, $source, $leave_time, $price, $url);
        		break;
        	case 'deleteProduct':
        		$productID = $_GET['pid'];
        		$this->deleteProduct($productID);
        		break;
        	case 'deleteConfirm':
        		$productID = $_GET['pid'];
        		$this->deleteConfirm($productID);
        		break;
        	case 'addProduct':
        		$this->addProduct();
        		break;
        	case 'add':
        		$name = $_POST['name'];
				$description = $_POST['description'];
				$destination = $_POST['destination'];
				$source = $_POST['source'];
				$leave_time = $_POST['leave_time'];
				$price = $_POST['price'];
				$url = $_POST['url'];
				if ($url == '') {
	    			$url = 'user-default.png';
	    		}
        		$this->add($name, $description, $destination, $source, $leave_time, $price, $url);
        		break;
            case 'loadMore':
                $itemNum = $_POST['item'];
                $this->loadMore($itemNum);
                break;
            case 'seatClick':
                $seat = $_POST['seat'];
                $productID = $_POST['pid'];
                $this->seatClick($seat, $productID);
                break;
      		// redirect to home page if all else fails
      		default:
		        header('Location: '.BASE_URL);
		        exit();
		}

	}

	//Switch to the List View
  	public function viewList() {
		$pageName = 'List';
        $productRes = Product::getInitialProducts();
		$myID = $_SESSION['id'];
        $user = User::loadById($myID);
        $array1;
        if ($user != null) {
            if ($user->get('following') == "") {
                $array1 = array();
            }
            else {
                $array1 = unserialize($user->get('following'));
            }
        }
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/list.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  	}

  	//Switch to the Product View
	public function viewProduct($id) {
		$pageName = 'Product';
	    $product = array();
	    $p = Product::loadById($id);

	    $product['id'] = $id;
	    $product['name'] = $p->get('name');
	    $product['description'] = $p->get('description');
	    $product['destination'] = $p->get('destination');
	    $product['source'] = $p->get('source');
	    $product['leave_time'] = $p->get('leave_time');
	    $product['price'] = $p->get('price');
	    $product['img_url'] = $p->get('img_url');
        $product['creator_id'] = $p->get('creator_id');

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/product.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  	}

  	//Go Back to the List View
  	public function back() {
		header('Location: '.BASE_URL.'/viewList/');
		exit();
	}

	//Switch to the Edit View
	public function editProduct($id) {
		$pageName = 'Edit Product';
		$product = array();
		$p = Product::loadById($id);

	    $product['id'] = $id;
	    $product['name'] = $p->get('name');
	    $product['description'] = $p->get('description');
	    $product['destination'] = $p->get('destination');
	    $product['source'] = $p->get('source');
	    $product['leave_time'] = $p->get('leave_time');
	    $product['price'] = $p->get('price');
	    $product['img_url'] = $p->get('img_url');

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/editProduct.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//Insert Data Changes to Product Database
	public function saveChanges($id, $name, $description, $destination, $source, $leave_time, $price, $url) {
        $product = Product::loadById($id);
        $product->set('name', $name);
        $product->set('description', $description);
        $product->set('destination', $destination);
        $product->set('source', $source);
        $product->set('leave_time', $leave_time);
        $product->set('price', $price);
        $product->set('img_url', $url);
        //save to database
        $product->save();
		header('Location: '.BASE_URL.'/viewList/');
		exit();
	}

	//Switch to Delete View
	public function deleteProduct($id) {
		$pageName = 'Delete Product';
		$product = array();
	    $p = Product::loadById($id);

	   	$product['id'] = $id;
	    $product['name'] = $p->get('name');
	    $product['description'] = $p->get('description');
	    $product['destination'] = $p->get('destination');
	    $product['source'] = $p->get('source');
	    $product['leave_time'] = $p->get('leave_time');
	    $product['price'] = $p->get('price');
	    $product['img_url'] = $p->get('img_url');

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/deleteProduct.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//Delete Specific Product from Product Database
	public function deleteConfirm($id) {
        Product::deleteByID($id);
		header('Location: '.BASE_URL.'/viewList/');
		exit();
	}

	//Switch to the Add View
	public function addProduct() {
		$pageName = 'Add Product';

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/addProduct.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//Insert New Data to the Product Database
	public function add($name, $description, $destination, $source, $leave_time, $price, $url) {
		$date = date('Y-m-d H:i:s');
		$id = $_SESSION['id'];
        $product = new Product();
        $product->set('name', $name);
        $product->set('description', $description);
        $product->set('destination', $destination);
        $product->set('source', $source);
        $product->set('leave_time', $leave_time);
        $product->set('price', $price);
        $product->set('img_url', $url);
        $product->set('date_created', $date);
        $product->set('creator_id', $id);
        //save to database
        $product->save();
		header('Location: '.BASE_URL.'/viewList/');
		exit();
	}


       public function loadMore($itemNum) {
        $newItems = Product::getMoreProducts($itemNum);
        if( sizeOf($newItems) == 0) {
            echo 'nothing';
            exit();
        }
		$myID =  $_SESSION['id'];
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
        foreach($newItems as $i) {
		
		
			//in case the array hasn't been made yet
			if($i->get('claimedArray') == "")
			{
				$array = array();
			}
			else
			{
				$array = unserialize($i->get('claimedArray'));
			}
			
			//numbers
			$green = $i->get('seats');
			$yellow = 0;
			foreach($array as $a)
			{
				if ($a == $_SESSION['id'])
				{
					$yellow = $yellow + 1;
				}
			}
			$red = count($array) - $yellow;//number claimed that isnt me.
			$green = $green - $red - $yellow;
            echo '<form method="POST">';
            echo '<div class="product small">';
            echo '<img class="product-image" src="' .BASE_URL.'/public/img/'.$i->get("img_url").'"/>';
    		echo '<h3><a href="'.BASE_URL.'/viewProduct/'.$i->get("id").'">To '.$i->get("destination").'</a></h3>';
    		echo '<p>From '.$i->get("source").'</p>';
    		echo '<p>'.$i->get("leave_time").'</p>';
    		echo '<p class="price">'.$i->get("price").'</p>';
            //session_start();
            if (isset($_SESSION['user']) && (($_SESSION['user'] === 'ADMIN') || ($i->get("creator_id") == $_SESSION['id']))) {
    		    echo '<button class="btn btn-warning" formaction="'.BASE_URL.'/editProduct/'.$i->get("id").'">Edit</button> ';
    			echo '<button class="btn btn-danger" formaction="'.BASE_URL.'/deleteProduct/'.$i->get("id").'">Delete</button> ';
    		}
			if(isset($_SESSION['user']) && in_array($i->get("creator_id"), $array)) {
				echo'<button class="btn btn-warning" formaction="'.BASE_URL. '/follow/'. $i->get("creator_id").'">Unfollow</button>';
			}
			 if(isset($_SESSION['user']) && !in_array($i->get("creator_id"), $array)) {
				echo'<button class="btn btn-success" formaction="'.BASE_URL. '/follow/'. $i->get("creator_id")	.'">Follow</button>';
            }

            if ($green > 0) {
				echo '<p class="seatInfo" id="'.$i->get('id').'" style="color:green;"> Click green slots to claim a seat! </p>';
			}
			else if ($i->get('seats') > 0) {
				echo '<p class="seatInfo" id="'.$i->get('id').'" style="color:red;"> There are no more available seats! </p>';
			}
			
			for ($x = 0; $x < $green; $x++) { 
				echo '<svg id="green" class="svg-seat" width="60" height="60">
					<rect class="seat" id="s1" x="5" y="5" width="50" height="50" style="fill:green;" onClick="seatClick(event, '.$i->get('id').');"/>
				</svg>';
			}
			for ($x = 0; $x < $yellow; $x++) {
	             echo '<svg id="yellow" class="svg-seat" width="60" height="60">
					<rect class="seat" id="s1" x="5" y="5" width="50" height="50" style="fill:yellow;" onClick="seatClick(event, '.$i->get('id').');"/>
				</svg>';
			}
			for ($x = 0; $x < $red; $x++) {
	             echo '<svg id="red" class="svg-seat" width="60" height="60">
					<rect class="seat" id="s1" x="5" y="5" width="50" height="50" style="fill:red;" onClick="seatClick(event, '.$i->get('id').');"/>
				</svg>';
			}
            echo '</div></form>';
        }
    }

    public function seatClick($seat, $productID) {
    	// IMPLEMENT
		if(isset($_SESSION['id']))
    	{
			$myID =  $_SESSION['id']; //logged in user
		}
		else
		{
			return;
		}
		
		//get product
		$product = Product::loadbyId($productID);
		if($product == NULL)
		{
			return; //return if the product doesn't exist
		}
        if ($product->get('claimedArray') == "") {
			$array = array(); //if array hasn't been made yet
		}
        else {
            $array = unserialize($product->get('claimedArray'));
        }
        
		if($seat == "green") //add user to array
		{
			if($product->get('seats') > count($array)) //cant add more riders than there are seats
			{
				array_push($array, $myID);
				$product->set('claimedArray', serialize($array));
			}
			else
			{
				return; // there are no open spots. This is to avoid malicious behaviour
			}
		}
		else if($seat == "yellow") //delete user from array
		{
			if(in_array($myID, $array))
			{
				$removed = 0;
				$newArray = array();
				foreach( $array as $i)
				{
					if($removed == 1 || $i != $myID)
					{
						array_push($newArray, $i);
					}
					else
					{
						$removed = 1;
					}
				}
				$array = $newArray;
				$product->set('claimedArray', serialize($newArray));
			}
			else
			{
				
				return;
			}
			
		}

		echo count($array);
		
		$product->save();
    }
}
