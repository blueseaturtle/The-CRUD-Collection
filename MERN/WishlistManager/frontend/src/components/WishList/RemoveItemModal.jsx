import React, { useState } from "react";
import {
  Grid,
  TextField,
  Modal,
  Backdrop,
  Fade,
  Button,
  Typography,
  makeStyles,
} from "@material-ui/core";
import { Alert } from "@material-ui/lab";

import styles from "../Customer/PersonalDetails/Personaldetails.module.scss";
import { dangerIcon } from "../../assets/images";

const useStyles = makeStyles((theme) => ({
  modal: {
    alignItems: "center",
    justifyContent: "center",
    width: "45%",
    display: "block",
    margin: "100px auto",
  },
  paper: {
    backgroundColor: "#f9f9f9",
    outline: "none",
    borderRadius: "15px",
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
  },
}));

const RemoveItemModal = ({ remove, itemId, name, price, author, imgSrc, publisher }) => {
  const classes = useStyles();
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleSubmit = () => {
    setOpen(false);
    console.log("ID",itemId)
    remove(itemId);
  };

  return (
    <React.Fragment>
      <div className={styles.removeBtn} onClick={handleOpen}>
        Remove from list
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
              <img
                src={dangerIcon}
                style={{ marginRight: "20px", height: "100px", width: "100px" }}
              />
              <div style={{ marginTop: "30px" }}>
                <Typography
                  variant="h5"
                  component="h2"
                  style={{ paddingBottom: "20px", fontWeight: "500" }}
                >
                  Remove this item from your wish list?
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
                  <Button
                    className={styles.deleteAcc}
                    style={{ marginTop: "25px" }}
                    onClick={handleSubmit}
                  >
                    REMOVE Item
                  </Button>
                  <Button
                    className={styles.canceldanger}
                    style={{ marginTop: "25px" }}
                    onClick={handleClose}
                  >
                    Cancel
                  </Button>
                </div>
              </div>
            </Grid>
          </div>
        </Fade>
      </Modal>
    </React.Fragment>
  );
};

export default RemoveItemModal;
