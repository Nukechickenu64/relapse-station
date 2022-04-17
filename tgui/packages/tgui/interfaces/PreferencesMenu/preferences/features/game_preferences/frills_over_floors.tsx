import { CheckboxInput, FeatureToggle } from "../base";

export const chromaticaberration: FeatureToggle = {
  name: "Enable frills over floors",
  category: "GAMEPLAY",
  description: "Enable frills over floors - When enabled frills only get hidden when a mob is near. When disabled, floors and open spaces hide frills.",
  component: CheckboxInput,
};
