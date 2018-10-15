/*jshint esversion: 6 */

var $ = require('jquery');
import {
  Socket,
  Presence
} from "phoenix";

let presences = {};
let onlineUsers = document.getElementById("online-users");
let name = window.user_name;
let token = window.token;
let socket =
  new Socket(
    "/socket", {
      params: {
        token: token
      }
    }
  );
socket.connect();
let channel = socket.channel("room", {token: token});
let message_input = $("#message-input");
let chat_messages = document.getElementById("chat-messages");

let renderUsers = (presences) => {
  let response = "";

  Presence.list(presences, (id, {metas: [first, ...rest]}) => {
    let count = rest.length + 1;
    response += `<br>${id} (count: ${count})</br>`;
  });

  onlineUsers.innerHTML = response;
};

message_input.focus();
message_input.on("keypress", event => {
  if (event.keyCode == 13) {
    channel.push("message:new", {
      message: message_input.val(),
      user: name
    });
    message_input.val("");
  }
});

channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

// Channel event listener callbacks
channel.on("message:new", payload => {
  let template = document.createElement("div");
  template.innerHTML = `<b>${payload.user}</b>:
                           ${payload.message}<br>`;

  chat_messages.appendChild(template);
  chat_messages.scrollTop = chat_messages.scrollHeight;
});

channel.on('presence_state', state => {
  presences = Presence.syncState(presences, state);
  renderUsers(presences);
});

channel.on('presence_diff', diff => {
  presences = Presence.syncDiff(presences, diff);
  renderUsers(presences);
});

export default socket;
