(ns clojure-webapp.core
  (:use compojure.core)
  (:require [compojure.handler :as handler]
            [compojure.route :as route]
            [ring.middleware.basic-authentication :refer :all]
            [ring.util.response :as resp]
            [clojure-webapp.webController.controller :as controller]
            [clojure-webapp.domain.employee :as employee-domain]
            [clojure-webapp.domain.project :as project-domain]))

(defroutes public-routes
           (GET "/" [] (controller/home))
           (route/resources "/")
           (GET "/index" [] (controller/home))
           (route/resources "/")
           (GET "/employees" [] (controller/employees))
           (route/resources "/")
           (GET "/projects" [] (controller/projects))
           (route/resources "/")
           (GET "/homepage" [] (controller/home))
           (route/resources "/")
           (GET "/allEmployees" [] (controller/allEmployees))
           (route/resources "/")
           (GET "/allProjects" [] (controller/allProjects))
           (route/resources "/")

           (GET "/domain/employees/:id/remove" [id]
             (do (employee-domain/removeEmployee id)
                 (resp/redirect "/allEmployees")))

           (GET "/domain/projects/:id/remove" [id]
             (do (project-domain/removeProject id)
                 (resp/redirect "/allProjects")))

           (POST "/domain/employees/insert" [& params]
             (do (employee-domain/insertEmployee params)
                 (resp/redirect "/allEmployees")))

           (POST "/domain/projects/insert" [& params]
             (do (project-domain/insertProject params)
                 (resp/redirect "/allProjects")))

           (GET "/domain/employees/:id/update" [id]
             (controller/updatingEmployee id))

           (POST "/domain/employees/:id_employee/update" [& params]
             (do (employee-domain/update (:id_employee params) params)
                 (resp/redirect "/allEmployees")))

           (GET "/domain/projects/:id/update" [id]
             (controller/updatingProject id))

           (POST "/domain/projects/:id_project/update" [& params]
             (do (project-domain/update (:id_project params) params)
                 (resp/redirect "/allProjects")))

           )



(defroutes app-routes
           public-routes
           (route/not-found "404. Page not found"))

(def -main
  (handler/site app-routes))