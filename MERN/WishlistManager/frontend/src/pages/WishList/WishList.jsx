import React, { useState, useEffect } from "react";
import {
  Grid,
  Typography,
  Button,
  Divider,
  TextField,
  Modal,
  Backdrop,
  Fade,
  makeStyles,
} from "@material-ui/core";

import styles from "./WishList.module.scss";
import { dangerIcon, okIcon } from "../../assets/images";
import { Alert } from "@material-ui/lab";

import { AppLayout, AWishListItemCard } from "../../components";
import { buyWishItem, getWishListByID } from "../../services/wishlistService";

const useStyles = makeStyles((theme) => ({
  modal: {
    alignItems: "center",
    justifyContent: "center",
    width: "40%",
    display: "block",
    margin: "120px auto",
  },
  paper: {
    backgroundColor: "#f9f9f9",
    outline: "none",
    borderRadius: "15px",
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
  },
}));

const WishList = (props) => {
  //Get from service
  const [wishList, setWishList] = useState([]);

  const [success, setSuccess] = React.useState(null);

  async function getListItems() {
    const response = await getWishListByID(props.match.params.id);

    if (response) {
      console.log(response.items);
      setWishList(response.items);
    } else {
      console.log(response);
    }
  }

  async function addWishItemToCart(itemID){
    const response = await buyWishItem(itemID, true);

    if (response) {
      getListItems()
    } else {
      console.log(response);
    }
  }

  useEffect(() => {
    getListItems();
  }, []);

  return (
    <React.Fragment>
      <AppLayout>
        <div style={{ margin: "80px 25px" }}>
          <Typography className={styles.pageHeading}>
            {props.match.params.fname.toUpperCase() + " " + props.match.params.lname.toUpperCase()}'s Wish
            List
          </Typography>
          <Divider style={{ margin: "20px 0px 30px 0px", width: "100%" }} />

          <div style={{ margin: "0px 30px" }}>
            {success ? (
              <Alert severity="success" style={{ marginBottom: "10px" }}>
                {success}
              </Alert>
            ) : null}
            <Grid container spacing={3}>
              {wishList.map((wishItem) => (
                <Grid item xs={3}>
                  <AWishListItemCard
                    itemId={wishItem._id}
                    name={wishItem.title}
                    author={wishItem.author}
                    price={wishItem.price}
                    buyItem={addWishItemToCart}
                    publisher={wishItem.publisher}
                    imgSrc={wishItem.image}
                    isBought={wishItem.isBought}
                    itemsInStock={wishItem.itemsInStock}
                    setSuccess={setSuccess}
                  />
                </Grid>
              ))}
            </Grid>
          </div>
        </div>
      </AppLayout>
    </React.Fragment>
  );
};

export default WishList;
