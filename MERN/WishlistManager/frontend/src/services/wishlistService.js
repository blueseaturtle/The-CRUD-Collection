const baseUrl = "http://localhost:6060/wishlist";

export async function getWishListByID(id) {
  const response = await fetch(baseUrl + "/" + id);
  console.log("Fetching details of " + id);
  if (response.ok) {
    return response.json();
  } else {
    return response.status(500).send({ error: "Error loading list" });
  }
}

export async function searchWishListByName(name) {
  const response = await fetch(baseUrl + "/search/" + name.toLowerCase());
  console.log("Searching for" + name);
  if (response.ok) {
    return response.json();
  } else {
    return response.status(500).send({ error: "Error loading list" });
  }
}

export async function createReport(month, year) {
  const userToken = localStorage.getItem("user-token");

  const response = await fetch(baseUrl + "/report/" + month + "/" + year, {
    method: "GET",

    // Adding headers to the request
    headers: {
      "auth-token": userToken,
      "Content-Type": "application/json; charset=UTF-8",
    },
  });
  if (response.ok) {
    return response.json();
  } else {
    return response
      .status(500)
      .send({ error: "Error generating report, please try logging in again." });
  }
}

export async function buyWishItem(itemId, boughtState) {
  const userToken = localStorage.getItem("user-token");

  const response = await fetch(baseUrl + "/buy-wish-item/" + itemId + "/" + boughtState, {
    method: "PATCH",

    // Adding headers to the request
    headers: {
      "auth-token": userToken,
      "Content-Type": "application/json; charset=UTF-8",
    },
  });
  if (response.ok) {
    return response.json();
  } else {
    return response
      .status(500)
      .send({ error: "Error adding item to cart, please try logging in again." });
  }
}

export async function getTopFiveTtems() {
  const userToken = localStorage.getItem("user-token");
  const response = await fetch(baseUrl + "/top/wish/items", {
    method: "GET",

    // Adding headers to the request
    headers: {
      "auth-token": userToken,
      "Content-Type": "application/json; charset=UTF-8",
    },
  });
  if (response.ok) {
    return response.json();
  } else {
    return response.status(500).send({ error: "Error loading list" });
  }
}

export async function addItemToList(itemDetails, listID) {
  const userToken = localStorage.getItem("user-token");
  try {
    const response = await fetch(baseUrl + "/" + listID, {
      method: "POST",

      // Adding body or contents to send
      body: JSON.stringify(itemDetails),

      // Adding headers to the request
      headers: {
        'auth-token': userToken,
        "Content-Type": "application/json; charset=UTF-8",
      },
    }).then((response) => {
      response.json().then((data) => {
        if (!response.ok) {
          throw response;
        } else {
          console.log("returned ", data);
          return data;
        }
      });
    });
  } catch (error) {
    let responseTxt = await error.text();
    return responseTxt;
  }
}

export async function updateListStatus(listID, listStatus) {
  const userToken = localStorage.getItem("user-token");
  try {
    const response = await fetch(baseUrl + "/" + listID + "/" + listStatus, {
      method: "PUT",

      headers: {
        'auth-token': userToken,
        "Content-Type": "application/json; charset=UTF-8",
      },
    });
    if (!response.ok) {
      throw response;
    } else {
      return "ok";
    }
  } catch (error) {
    let responseTxt = await error.text();
    return responseTxt;
  }
}

export async function newList(listID) {
  try {
    const newList = {
      userid: listID,
    };
    const response = await fetch("http://localhost:6060/wishlist/new", {
      method: "POST",

      // Adding body or contents to send
      body: JSON.stringify(newList),

      // Adding headers to the request
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
    });
    if (!response.ok) {
      throw response;
    } else {
      return "ok";
    }
  } catch (error) {
    let responseTxt = await error.text();
    return responseTxt;
  }
}

export async function deleteItemFromList(itemID, listID) {
  const userToken = localStorage.getItem("user-token");
  try {
    const response = await fetch(baseUrl + "/" + listID + "/" + itemID, {
      method: "DELETE",

      headers: {
        'auth-token': userToken,
        "Content-Type": "application/json; charset=UTF-8",
      },
    });

    if (!response.ok) {
      throw response;
    } else {
      return "ok";
    }
  } catch (error) {
    let responseTxt = await error.text();
    return responseTxt;
  }
}
