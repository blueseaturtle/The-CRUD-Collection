import React, { useState } from "react";
import { APP_ROUTES } from "../../../utilities/constants/routes.constants";
import { AppLayoutHeader } from "../index";
import Footer from "../../Customer/Homepage/Footer/Footer";

const AppLayout = ({ children, componentTitle }) => {
  return (
    <React.Fragment>
      <div>
        <aside className="content">
          <AppLayoutHeader />
          <div style={{ marginTop: "45px" }}>{children}</div>
          <div style={{ width: "99%" }}>
            <Footer />
          </div>
        </aside>
      </div>
    </React.Fragment>
  );
};

export default AppLayout;
