import React, { useState } from "react";

import styles from "./Home.module.scss";
import {
  appLogo,
  leftColImg,
  rightColImg,
  toolBarIcon1,
} from "../../assets/images";
import {
  AppBar,
  Grid,
  Paper,
  Toolbar,
  Stack,
  TextField,
  IconButton,
  Avatar,
  Container,
  Typography,
  Snackbar,
} from "@mui/material";
import { Box } from "@mui/system";
import { ENDPOINTS } from "../../utilities/constants/endpoints.constants";

const Home = () => {
  const [chatBubbles, setChatBubbles] = useState([]);

  const [userResponse, setUserResponse] = useState("");

  const [error, setError] = useState(false);
  const [loading, setLoading] = useState(false);

  const vowels = ["a", "e", "i", "o", "u"];

  const submitResponse = async (event) => {
    event.preventDefault();
    setError(false);
    if (userResponse.length > 4 && /^[a-zA-Z ]+$/.test(userResponse)) {
      setChatBubbles((currentChat) => [...currentChat, userResponse]);
      setUserResponse("");

      const wordEnding = vowels.includes(
        userResponse.charAt(userResponse.length - 2)
      )
        ? userResponse.slice(-2)
        : userResponse.slice(-3);

      setLoading(true);

      //Get rhymes
      const response = await fetch(
        ENDPOINTS.BASE_URL +
          ENDPOINTS.SEARCH_RHYME +
          wordEnding +
          "/" +
          userResponse.toLowerCase(),
        {
          method: "GET",
          headers: { "Content-Type": "application/json" },
        }
      );

      setLoading(false);

      if (response.status !== 404) {
        const rhymes = await response.json();

        //Picking a random rhyme
        const sentence =
          rhymes[Math.floor(Math.random() * rhymes.length) + 0].sentenceString;

        setChatBubbles((currentChat) => [
          ...currentChat,
          sentence[0].toUpperCase() + sentence.slice(1),
        ]);
      } else {
        setChatBubbles((currentChat) => [
          ...currentChat,
          "No rhymes. You win!",
        ]);
      }

      //Save user response
      const savedResponse = await fetch(
        ENDPOINTS.BASE_URL + ENDPOINTS.ADD_NEW,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            string: userResponse.toLowerCase(),
            wordEnding: wordEnding,
          }),
        }
      );
    } else {
      setError(true);
    }
  };

  return (
    <React.Fragment>
      <AppBar elevation={0}>
        <Toolbar className={styles.toolBar}>
          <Box sx={{ flexGrow: 1 }}>
            <img
              src={appLogo}
              style={{
                height: 50,
              }}
            />
          </Box>
          <IconButton
            target="_blank"
            href="https://github.com/methminug/RhymePingPong"
          >
            <Avatar src={toolBarIcon1} />
          </IconButton>
        </Toolbar>
      </AppBar>
      <Grid container direction="row" className="content-padding">
        <Box
          component={Grid}
          item
          display={{ md: "block", xs: "none" }}
          md={3}
          xs={1}
          className={styles.column}
        >
          <img
            src={leftColImg}
            className={styles.logo}
            style={{ width: 250, marginTop: 100 }}
          />
        </Box>
        <Box
          component={Grid}
          item
          direction="column"
          className={styles.centerColumn}
          md={6}
          xs={12}
        >
          <Paper
            elevation={10}
            sx={{
              width: "100%",
              height: "70vh",
              backgroundColor: "#383e8c",
              borderRadius: 2,
              overflow: "hidden",
            }}
          >
            <Box
              display={{ md: "block", xs: "none" }}
              component={Grid}
              sx={{
                width: "50%",
                height: "70vh",
                position: "absolute",
              }}
            >
              <Box
                sx={{
                  width: "5px",
                  height: "100%",
                  backgroundColor: "white",
                  position: "relative",
                  left: "50%",
                }}
              />
            </Box>
            <Box
              display={{ md: "none", xs: "block" }}
              component={Grid}
              sx={{
                width: "100%",
                height: "70vh",
                position: "absolute",
              }}
            >
              <Box
                sx={{
                  width: "5px",
                  height: "100%",
                  backgroundColor: "white",
                  position: "relative",
                  left: "50%",
                }}
              />
            </Box>
            <Stack
              sx={{
                height: "70vh",
                display: "flex",
                justifyContent: "flex-end",
                alignContent: "flex-end",
                paddingBottom: 3,
              }}
            >
              <Container>
                {chatBubbles.map((chatText, index) =>
                  index % 2 === 0 ? (
                    <Box
                      container
                      direction="row"
                      display="flex"
                      justifyContent="flex-end"
                    >
                      <Box component={Grid} xs={5}>
                        <Paper
                          elevation={1}
                          sx={{
                            padding: 1,
                            backgroundColor: "#d4f6cc",
                            borderRadius: 3,
                          }}
                        >
                          <Typography key={index}>{chatText} 🏓</Typography>
                        </Paper>
                      </Box>
                    </Box>
                  ) : (
                    <Box container direction="row">
                      <Box component={Grid} xs={5}>
                        <Paper
                          elevation={1}
                          sx={{
                            padding: 1,
                            backgroundColor: "white",
                            borderRadius: 3,
                          }}
                        >
                          <Typography key={index}>🏓 {chatText}</Typography>
                        </Paper>
                      </Box>
                    </Box>
                  )
                )}
              </Container>
            </Stack>
          </Paper>
          <form
            onSubmit={submitResponse}
            style={{ width: "100%", margin: 0, padding: 0 }}
          >
            <TextField
              label="Type a sentence here. Press enter key to SERVE!"
              value={userResponse}
              autoComplete="off"
              onChange={(e) => setUserResponse(e.target.value)}
              sx={{
                marginTop: 2,
                marginBottom: 2,
                backgroundColor: "white",
                width: "100%",
                borderRadius: 2,
              }}
            />
          </form>
          <Snackbar
            open={error}
            autoHideDuration={5000}
            anchorOrigin={{ vertical: "bottom", horizontal: "right" }}
            message="Please enter a sentence with no numbers or special characters."
            onClose={(e) => {
              setError(false);
            }}
          />

          <Snackbar
            open={loading}
            message="RHYMING . . ."
            onClose={(e) => {
              setLoading(false);
            }}
          />
        </Box>
        <Box
          component={Grid}
          item
          display={{ md: "block", xs: "none" }}
          md={3}
          xs={1}
          className={styles.rightColumn}
        >
          <img
            src={rightColImg}
            style={{ width: 250, marginTop: "100%", marginLeft: "20%" }}
          />
        </Box>
      </Grid>
    </React.Fragment>
  );
};

export default Home;
