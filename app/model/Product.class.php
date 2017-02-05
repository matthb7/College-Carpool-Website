<?php

class Product extends DbObject {
    // name of database table
    const DB_TABLE = 'product';

    // database fields
    protected $id;
    protected $name;
    protected $description;
    protected $destination;
    protected $source;
    protected $leave_time;
    protected $price;
    protected $img_url;
    protected $creator_id;
    protected $date_created;
    protected $claimedArray;
    protected $seats;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'name' => '',
            'description' => null,
            'destination' => '',
            'source' => '',
            'leave_time' => '',
            'price' => 0,
            'img_url' => null,
            'creator_id' => 0,
            'date_created' => null,
            'claimedArray' => '',
            'seats' => 0
        );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->name = $args['name'];
        $this->description = $args['description'];
        $this->destination = $args['destination'];
        $this->source = $args['source'];
        $this->leave_time = $args['leave_time'];
        $this->price = $args['price'];
        $this->img_url = $args['img_url'];
        $this->creator_id = $args['creator_id'];
        $this->date_created = $args['date_created'];
        $this->claimedArray = $args['claimedArray'];
        $this->seats = $args['seats'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'name' => $this->name,
            'description' => $this->description,
            'destination' => $this->destination,
            'source' => $this->source,
            'leave_time' => $this->leave_time,
            'price' => $this->price,
            'img_url' => $this->img_url,
            'creator_id' => $this->creator_id,
            'claimedArray' => $this->claimedArray,
            'seats' => $this->seats
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    // load all products
    public static function getAllProducts($limit=null) {
        $query = sprintf(" SELECT id FROM %s ORDER BY date_created DESC ",
            self::DB_TABLE
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    // Get first # of products
    public static function getInitialProducts($limit=null) {
        $query = sprintf(" SELECT id FROM %s ORDER BY id
            ASC LIMIT 0, 3", self::DB_TABLE);
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    // load two new products
    public static function getMoreProducts($start) {
        $query = sprintf(" SELECT * FROM %s ORDER BY id ASC LIMIT $start, 2",
            self::DB_TABLE
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    // Load all of a specific user's rides
    public static function getAllUsersRides($user) {
        $query = sprintf(" SELECT id FROM %s WHERE creator_id = %s ORDER BY date_created DESC ",
            self::DB_TABLE,
            $user
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    //Deletes a specific product from the databasepublic static function
    public static function deleteById($id) {
        $query = sprintf(" DELETE FROM %s WHERE id = %d ",
            self::DB_TABLE, $id);
        $db = Db::instance();
        $db->execute($query);
    }
}
