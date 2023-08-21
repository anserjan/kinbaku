document.addEventListener("DOMContentLoaded", function () {
  const sub_menu_toggles = document.querySelectorAll(".sub__menu__toggle");
  sub_menu_toggles.forEach(sub_menu_toggle => {
    sub_menu_toggle.addEventListener("click", () => {
      // first close every menu before opening the specific one
      sub_menu_toggles.forEach(to_close_sub_menu_toggle => {
        if(to_close_sub_menu_toggle == sub_menu_toggle) { return; }
        to_close_sub_menu_toggle.classList.remove("active");
      })
      sub_menu_toggle.classList.toggle("active");
    })
  });
});