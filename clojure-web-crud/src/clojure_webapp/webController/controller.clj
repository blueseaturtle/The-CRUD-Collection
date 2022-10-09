(ns clojure-webapp.webController.controller
  (:require
    [clostache.parser :as clostache]
    [clojure-webapp.domain.employee :as employee-domain]
    [clojure-webapp.domain.project :as project-domain]
    ))

(defn read-template [template-name]
  (slurp (clojure.java.io/resource
           (str "pages/" template-name ".mustache"))))

(defn render-template [template-file params]
  (clostache/render (read-template template-file) params))


(defn home []
  (render-template "homepage" {}))

(defn index []
  (render-template "index" {}))

(defn allEmployees []
  (render-template "allEmployees" {:employee (employee-domain/allEmployees)
                               :department (employee-domain/allDepartments)}))

(defn allProjects []
  (render-template "allProjects" {:project (project-domain/allProjects)
                               :projecttype (project-domain/allProjectTypes)}))

(defn employees[]
  (render-template "employees" {:employee (employee-domain/allEmployees)
                            :department (employee-domain/allDepartments)}))

(defn updatingEmployee [id]
  (render-template "updateEmployee" {:employee (employee-domain/get id)
                                 :department (employee-domain/allDepartments)}))

(defn updatingProject [id]
  (render-template "updateProject" {:project (project-domain/get id)
                                     :projecttype (project-domain/allProjectTypes)}))


(defn projects []
  (render-template "projects" {:project (project-domain/allProjects)
                                :projecttype (project-domain/allProjectTypes)}))