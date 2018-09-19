LRObject.util.ready(function() {
  LRObject.loginScreen("loginscreen-container", options)
});

let options = {
  redirecturl: {
    afterlogin: "<Profile Link>",
    afterreset: "<Index Link>"
  }
}
