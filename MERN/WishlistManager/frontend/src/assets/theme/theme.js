import { createTheme, makeStyles } from "@material-ui/core";
import { withStyles } from "@material-ui/core/styles";
import TableCell from "@material-ui/core/TableCell";
import TableRow from "@material-ui/core/TableRow";

export const PrimaryTheme = createTheme({
    palette: {
        primary: {
            main: "#008080"
        },
        secondary:{
            main: "#ebf6f7"
        },
        danger:{
            main:"#f57373"
        },
        text:{
            disabled: "#555555"
        }
    }
});

export const useStyle = makeStyles(theme => ({
    root:{
        '& .MuiFormControl-root':{
            width:'80%'
        }

    }
}))

export const useStyles = makeStyles(theme =>({
    pageContent:{
        margin: theme.spacing(5),
        padding: theme.spacing(3)
    }
}))

export const customStyles = {
    control: (base) => ({
        ...base,
        height: 55,
        minHeight: 35
    })
};

export const StyledTableCell = withStyles((theme) => ({
  head: {
    fontWeight: 600,
    padding: "10px",
    fontSize: 18,
  },
  body: {
    fontSize: 15,
    padding: "6px",
  },
}))(TableCell);

export const StyledTableRow = withStyles((theme) => ({
  root: {
    "&:nth-of-type(odd)": {
      backgroundColor: "#FFFFFF",
    },
  },
}))(TableRow);
