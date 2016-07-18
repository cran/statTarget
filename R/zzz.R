.onAttach <- function(...) {
  packageStartupMessage("\nUse 'statTargetGUI()' to restart the programe.\n",fill=TRUE)
  #statTarget::statTargetGUI()
  if (interactive()) statTarget.gui()
}
