(ns clojure-webapp.domain.employee
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

(defn allEmployees []
  (jdbc/query mysql-db
              ["SELECT * FROM employee b"]))


(defn allDepartments []
  (jdbc/query mysql-db
              ["SELECT * FROM department d"]))


(defn get [id]
  (first (jdbc/query mysql-db
                     ["SELECT * FROM employee WHERE id_employee = ?" id])))


(defn removeEmployee [id]
  (jdbc/execute! mysql-db
                 ["DELETE FROM employee WHERE id_employee = ?" id]))


(defn update [id params]
  (jdbc/update! mysql-db :employee params (sql/where {:id_employee id})))

(defn insertEmployee
  [params]
  (jdbc/insert! mysql-db :employee params))