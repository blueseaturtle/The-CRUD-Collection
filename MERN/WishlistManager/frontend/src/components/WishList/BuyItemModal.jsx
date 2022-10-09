import React, { useState } from "react";
import {
  Grid,
  FormControlLabel,
  Checkbox,
  Modal,
  Backdrop,
  Fade,
  Button,
  Typography,
  makeStyles,
} from "@material-ui/core";

import styles from "../Customer/PersonalDetails/Personaldetails.module.scss";

const useStyles = makeStyles((theme) => ({
  modal: {
    alignItems: "center",
    justifyContent: "center",
    width: "fit-content",
    display: "block",
    margin: "100px auto",
  },
  paper: {
    backgroundColor: "#f9f9f9",
    outline: "none",
    borderRadius: "15px",
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 6, 3),
  },
}));

const BuyItemModal = ({ buy, itemId, name, price, author, imgSrc, setSuccess, publisher }) => {
  const classes = useStyles();
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setSuccess(null);
    setOpen(false);
  };

  const handleSubmit = () => {
    setOpen(false);
    buy(itemId);
    setSuccess("Item added to cart");
    setTimeout(() => setSuccess(null),3000)
  };

  return (
    <React.Fragment>
      <div
        className={styles.signInBtn}
        style={{ cursor: "pointer", fontWeight: "300", width: "100%", textAlign:"center" }}
        onClick={handleOpen}
      >
        Add to cart
      </div>
      <Modal
        aria-labelledby="transition-modal-title"
        aria-describedby="transition-modal-description"
        className={classes.modal}
        open={open}
        closeAfterTransition
        BackdropComponent={Backdrop}
        BackdropProps={{
          timeout: 500,
        }}
      >
        <Fade in={open}>
          <div className={classes.paper}>
            <Grid container direction="row">
              <div style={{ marginTop: "10px" }}>
                <Typography
                  variant="h5"
                  component="h2"
                  style={{
                    paddingBottom: "20px",
                    fontWeight: "300",
                    color: "#5f5e5e",
                  }}
                >
                  Buy this item from this wish list?
                </Typography>
                <div>
                  <Grid container direction="row" spacing={3}>
                    <Grid item>
                      <img height="130px" width="auto" src={imgSrc} />
                    </Grid>
                    <Grid item>
                      <Typography className={styles.descText2}>
                        {name}
                      </Typography>
                      <Typography className={styles.descText}>
                        {author}
                      </Typography>
                      <Typography className={styles.descText} style={{fontStyle:"italic"}}>
                        {publisher}
                      </Typography>
                      <Typography className={styles.descText2}>
                        Rs. {price}
                      </Typography>
                    </Grid>
                  </Grid>
                  <Grid container direction="column">                    
                    <div style={{marginTop: "10px"}}>
                      <Button
                        className={styles.signInBtn}
                        style={{
                          cursor: "pointer",
                          fontWeight: "300",
                        }}
                        onClick={handleSubmit}
                      >
                        Add to cart
                      </Button>
                      <Button
                        className={styles.cancel}
                        style={{
                          fontWeight: "normal",
                          borderWidth: "1px",
                        }}
                        onClick={handleClose}
                      >
                        Cancel
                      </Button>
                    </div>
                  </Grid>
                  <Typography style={{ marginTop: "10px" }}>
                    * This item will be shipped to the owner of this wishlist
                  </Typography>
                  
                </div>
              </div>
            </Grid>
          </div>
        </Fade>
      </Modal>
    </React.Fragment>
  );
};

export default BuyItemModal;
