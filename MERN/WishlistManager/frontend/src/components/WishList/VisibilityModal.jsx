import React, { useState } from "react";
import {
  Grid,
  TextField,
  Modal,
  Backdrop,
  Fade,
  Button,
  Typography,
  Switch,
  FormControlLabel,
  makeStyles,
} from "@material-ui/core";
import { Alert } from "@material-ui/lab";
import { withStyles } from "@material-ui/core/styles";

import styles from "../Customer/PersonalDetails/Personaldetails.module.scss";
import { questionIcon } from "../../assets/images";

const useStyles = makeStyles((theme) => ({
  modal: {
    alignItems: "center",
    justifyContent: "center",
    width: "47%",
    display: "block",
    margin: "80px auto",
  },
  paper: {
    backgroundColor: "#f9f9f9",
    outline: "none",
    borderRadius: "15px",
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
  },
}));

const VisibilitySwitch = withStyles((theme) => ({
  root: {
    width: 52,
    height: 26,
    padding: 0,
    margin: theme.spacing(1),
  },
  switchBase: {
    padding: 1,
    "&$checked": {
      transform: "translateX(26px)",
      color: "#008080",
      "& + $track": {
        backgroundColor: "#abd4d4",
        opacity: 1,
        border: "none",
      },
    },
    "&$focusVisible $thumb": {
      color: "#80c0c0",
      border: "6px solid #fff",
    },
  },
  thumb: {
    width: 24,
    height: 24,
  },
  track: {
    borderRadius: 26 / 2,
    border: `1px solid ${theme.palette.grey[400]}`,
    backgroundColor: "#cbcbcb",
  },
  checked: {},
  focusVisible: {},
}))(({ classes, ...props }) => {
  return (
    <Switch
      focusVisibleClassName={classes.focusVisible}
      disableRipple
      classes={{
        root: classes.root,
        switchBase: classes.switchBase,
        thumb: classes.thumb,
        track: classes.track,
        checked: classes.checked,
      }}
      {...props}
    />
  );
});

const VisibilityModal = ({ isPublic, updateStatus }) => {
  const classes = useStyles();
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleSubmit = () => {
    setOpen(false)
    updateStatus(isPublic)
  };

  return (
    <React.Fragment>
      <FormControlLabel
        value="start"
        control={<VisibilitySwitch checked={isPublic} onChange={handleOpen} />}
        label={<span className={styles.switchLabel}>Public list</span>}
        labelPlacement="start"
      />
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
                src={questionIcon}
                style={{ marginRight: "20px", height: "100px", width: "100px" }}
              />
              <div style={{ marginTop: "30px" }}>
                <Typography
                  variant="h5"
                  component="h2"
                  style={{ paddingBottom: "10px" }}
                >
                  Make wish list {isPublic ? "private?" : "public?"}
                </Typography>
                <div>
                  <div style={{width:"450px"}}>
                  {isPublic ? (
                    <Typography className={styles.descText}>
                      This hides your list from everyone searching the wish lists page of this site.
                    </Typography>
                  ) : (
                    <Typography className={styles.descText}>
                      This makes your list visible to anyone searching the wish lists page of this site.<br />
                      <span style={{fontWeight:"500"}}>Note: Your delivery address will not be visible to others.</span>
                    </Typography>
                  )}
                  </div>
                  <Button
                    className={styles.signInBtn}
                    style={{ marginTop: "15px" }}
                    onClick={handleSubmit}
                  >
                    Make my list {isPublic ? "private" : "public"}
                  </Button>
                  <Button
                    className={styles.cancel}
                    style={{ marginTop: "15px" }}
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

export default VisibilityModal;
