import React from "react";
import {
  Table,
  TableHead,
  TableRow,
  TableBody,
  Button,
  Typography,
} from "@material-ui/core";

import { StyledTableCell, StyledTableRow } from "../../assets/theme/theme";
import { APP_ROUTES } from "../../utilities/constants/routes.constants";

const WishListTable = ({ resultList }) => {
  return (
    <React.Fragment>
      <Table>
        <TableHead>
          <TableRow>
            <StyledTableCell align="left">List owners's name</StyledTableCell>
            {/* <StyledTableCell align="left">Location</StyledTableCell> */}
          </TableRow>
        </TableHead>
        <TableBody>
          {resultList[0]?._id === -1 ? (
            <StyledTableRow>
              <StyledTableCell colSpan={12} align="center">
                <Typography>Search results will appear here</Typography>
              </StyledTableCell>
            </StyledTableRow>
          ) : resultList.length > 0 ? (
            resultList.map((wishListResult) => (
              <StyledTableRow key={wishListResult._id}>
                <StyledTableCell align="left">
                  <Button
                    href={
                      APP_ROUTES.A_WISHLIST +
                      wishListResult._id +
                      "/" +
                      wishListResult.name.split(" ")[0] +
                      "/" +
                      wishListResult.name.split(" ")[1]
                    }
                  >
                    {wishListResult.name}
                  </Button>
                </StyledTableCell>
                {/* <StyledTableCell align="left">
        {wishListResult.location}
      </StyledTableCell> */}
              </StyledTableRow>
            ))
          ) : (
            <StyledTableRow>
              <StyledTableCell colSpan={12} align="center">
                <Typography>Sorry, no wishlists for this name</Typography>
              </StyledTableCell>
            </StyledTableRow>
          )}
        </TableBody>
      </Table>
    </React.Fragment>
  );
};

export default WishListTable;
