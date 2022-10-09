(ns clojure-webapp.domain.user
  (:refer-clojure :exclude [get])
  (:require [clojure.java.jdbc :as jdbc]
            [clojure.java.jdbc.sql :as sql]))

(def mysql-db {
               :subprotocol "mysql"
               :subname "//localhost:3306/clojure_db_taskassign"
               :user "root"
               :password ""
               :zeroDateTimeBehaviour "convertToNull"
               })

(def now (str (java.sql.Timestamp. (System/currentTimeMillis))))

(defn getByUsername [username]
  (first (jdbc/query mysql-db
                     ["SELECT * FROM user WHERE username = ?" username])))

(defn getUserByPassword [password]
  (first (jdbc/query mysql-db
                     ["SELECT * FROM user WHERE password = ?" password])))