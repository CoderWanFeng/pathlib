
import Want from '@ohos.app.ability.Want';
import AbilityStage from '@ohos.app.ability.AbilityStage';

export default class AppAbilityStage extends AbilityStage {
  onCreate(): void {

  }

  onAcceptWant(want: Want): string {
    return ""
  }
}
