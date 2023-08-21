document.addEventListener("DOMContentLoaded", function () {
  const sub_menu_toggles = document.querySelectorAll(".sub__menu__toggle");
  sub_menu_toggles.forEach(sub_menu_toggle => {
    sub_menu_toggle.addEventListener("click", () => {
      sub_menu_toggles.forEach(smt => {smt.classList.remove("active");});
      sub_menu_toggle.classList.add("active");
    })
  });
});