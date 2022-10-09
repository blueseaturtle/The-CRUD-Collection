import React, { useState } from "react";
import { Grid, Card, Typography, Button } from "@material-ui/core";

import styles from "./WishItemCard.module.scss";
import BuyItemModal from "./BuyItemModal";

const AWishListItemCard = ({
  itemId,
  name,
  author,
  price,
  buyItem,
  isBought,
  itemsInStock,
  imgSrc,
  publisher,
  setSuccess 
}) => {
  return (
    <Card style={{ padding: "25px 20px" }} variant="outlined">
      <div style={{ display: "flex", justifyContent: "center" }}>
          <img height="130px" width="auto" src={imgSrc} />
      </div>
      <Typography className={styles.mainText}>{name}</Typography>
      <p className={styles.subText}>{author}</p>
      <p className={styles.subText2}>{publisher}</p>
      <p className={styles.subText}>Rs. {price}</p>
      {isBought ? (
        <div className={styles.bought}>BOUGHT</div>
      ) : itemsInStock === 0 ? (
        <div className={styles.outOfStock}>OUT OF STOCK</div>
      ) : (
        <div style={{ display: "flex", justifyContent: "flex-end" }}>
          <BuyItemModal
            buy={buyItem}
            name={name}
            author={author}
            price={price}
            itemId={itemId}
            imgSrc={imgSrc}
            publisher={publisher}
            setSuccess={setSuccess}
          />
        </div>
      )}
    </Card>
  );
};

export default AWishListItemCard;
