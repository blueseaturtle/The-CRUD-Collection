(ns clojure-webapp.domain.project
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

(defn allProjects []
  (jdbc/query mysql-db
              ["SELECT * FROM project p"]))

(defn allProjectTypes []
  (jdbc/query mysql-db
              ["SELECT * FROM projecttype ti"]))

(defn removeProject [id]
  (jdbc/execute! mysql-db
                 ["DELETE FROM project WHERE id_project = ?" id]))

(defn get [id]
  (first (jdbc/query mysql-db
                     ["SELECT * FROM project WHERE id_project = ?" id])))


(defn update [id params]
  (jdbc/update! mysql-db :project params (sql/where {:id_project id})))


(defn insertProject
  [params]
  (jdbc/insert! mysql-db :project params))