import React, { useState } from "react";
import { Grid, Typography, Button, TextField } from "@material-ui/core";
import { Alert } from "@material-ui/lab";

import styles from "./WishList.module.scss";

import { AppLayout, WishListTable } from "../../components";
import {searchWishListByName } from "../../services/wishlistService";
import jwt_decode from "jwt-decode";


const SearchWishList = () => {
  const [ownerName, setOwnerName] = useState("");

  const [error, setError] = useState(null);

  const [searchResults, setSearchResults] = useState([{
    _id : -1
  }]);

  async function searchForList() {
    setSearchResults([{
      _id : -1
    }])
    setError(null);
    if (ownerName === "") {
      setError("Please enter a name to search");
      setTimeout(() => setError(null), 3000);
    } else {
      //Search
      const response = await searchWishListByName(ownerName);

      if (response) {
        console.log(response.lists);
        const userToken = localStorage.getItem("user-token");

        if (userToken != null) {
          const decodedToken = jwt_decode(userToken, { complete: true });
          console.log(response.lists)
          console.log(decodedToken.id)
          setSearchResults(response.lists.filter((list) => list._id !== decodedToken.id))
        }else{
          setSearchResults(response.lists)
        }

        
      } else {
        console.log(response);
      }
    }
  };

  return (
    <React.Fragment>
      <AppLayout>
        <Grid
          container
          className="content-padding"
          className={styles.background}
          style={{ height: "92vh" }}
        >
          <Grid
            item
            sm={3}
            xs={12}
            style={{ marginTop: "30px", borderRight: "1px solid #c8c6c6" }}
          >
            <Typography
              variant="h5"
              component="h2"
              style={{ fontWeight: "600" }}
            >
              Find a wish list
            </Typography>
            <Typography
              variant="body1"
              style={{ color: "#5b5b5b", padding: "30px 0px 20px 0px" }}
            >
              Get the perfect present by buying an item from a wish list!
            </Typography>
            <Typography
              variant="body1"
              style={{
                color: "#505050",
                paddingBottom: "10px",
                fontWeight: "bold",
              }}
            >
              Enter a name and find a wish list
            </Typography>
            <TextField
              className={styles.modalTextField}
              id="ownerName"
              value={ownerName}
              label="List owner's name"
              onChange={(e) => setOwnerName(e.target.value)}
              variant="filled"
              style={{width: "90%" }}
            />
            <Button
              className={styles.searchbtn}
              style={{ margin: "20px 0px", width: "90%" }}
              onClick={searchForList}
            >
              Search for list
            </Button>
            {error ? <Alert severity="warning" style={{border: "1px solid #f5d872", width:"90%"}}>{error}</Alert> : null}
          </Grid>
          <Grid
            item
            sm={9}
            xs={12}
            style={{ marginTop: "30px", paddingLeft: "50px" }}
          >
            <Typography
              variant="h5"
              component="h2"
              style={{ color: "#474747", paddingBottom: "30px" }}
            >
              Search results
            </Typography>
            <WishListTable resultList={searchResults} />
          </Grid>
        </Grid>
      </AppLayout>
    </React.Fragment>
  );
};

export default SearchWishList;
