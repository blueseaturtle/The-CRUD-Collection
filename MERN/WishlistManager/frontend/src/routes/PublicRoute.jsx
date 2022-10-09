import React from "react";
import {Route} from "react-router-dom";

const PublicRoute = ({Component, path, ...rest}) => {
    return(
        <Route
            {...rest}
            path={path}
            render={(props) => {
                return <Component {...props} />;
            }}
        />
    )
}

export default PublicRoute;