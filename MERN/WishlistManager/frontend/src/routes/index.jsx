import React from "react";
import { Router } from "react-router-dom";
import { createBrowserHistory } from "history";
import PrivateRoute from "./PrivateRoute";
import PublicRoute from "./PublicRoute";
import { APP_ROUTES } from "../utilities/constants/routes.constants";

import { WishList, SearchWishList, WishListReport, MyWishList } from "../pages";

const AppRoutes = () => {
  const history = createBrowserHistory();

  return (
    <Router history={history}>
      <PublicRoute path={APP_ROUTES.USER_WISHLIST} Component={MyWishList} />
      <PublicRoute
        path={APP_ROUTES.A_WISHLIST + ":id/:fname/:lname"}
        Component={WishList}
      />
      <PublicRoute
        exact
        path={APP_ROUTES.WISHLIST_SEARCH}
        Component={SearchWishList}
      />
      <PublicRoute
        path={APP_ROUTES.ADMIN_REPORT_WISHLIST}
        Component={WishListReport}
      />
    </Router>
  );
};

export default AppRoutes;
