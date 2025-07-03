import { ConsoleViewController } from "../components/console_view/ConsoleViewController";

export let consoleController: ConsoleViewController

export function  registerController(controller:ConsoleViewController) {
  consoleController = controller;
}

export function _info(msg: string) {
  console.log('[__app]', msg);
  if (consoleController) {
    consoleController.appendLog(msg);
  }
}