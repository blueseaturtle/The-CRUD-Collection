const express = require("express");
const router = express.Router();
const wishlistcontroller = require("../controllers/wishList.controller");
const verifyAdmin = require("../routers/verifyTokenAdmin")
const verifyBuyer = require("../routers/verifyTokenBuyer")

//Add proper routing nouns
module.exports = () => {
    router.post('/:id', verifyBuyer, wishlistcontroller.addWishListItem);
    router.get('/:id', wishlistcontroller.getWishListItems);
    router.get('/search/:name', wishlistcontroller.searchWishList);
    router.get('/top/wish/items', verifyAdmin, wishlistcontroller.getTopFiveProducts);
    router.get('/report/:month/:year', verifyAdmin, wishlistcontroller.genarateReport);
    router.delete('/:listid/:itemid', verifyBuyer, wishlistcontroller.deleteWishListItem);
    router.put('/:listid/:liststate', verifyBuyer, wishlistcontroller.updateisPrivate);
    router.patch('/buy-wish-item/:itemid/:boughtstate', verifyBuyer, wishlistcontroller.buyProductFromWishList);
    return router;
}