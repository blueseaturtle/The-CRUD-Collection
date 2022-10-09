import "./App.css";
import React from "react";
import AppRoutes from "./routes";
import { PrimaryTheme } from "./assets/theme/theme";
import { ThemeProvider } from "@material-ui/core";

function App() {
  return (
    <ThemeProvider theme={PrimaryTheme}>
      <AppRoutes />
    </ThemeProvider>
  );
}

export default App;
