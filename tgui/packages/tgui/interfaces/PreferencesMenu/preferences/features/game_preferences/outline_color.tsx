import { Feature, FeatureColorInputNoMutant } from "../base";

export const outline_color: Feature<string> = {
  name: "Outline Color",
  category: "UI",
  description: "Color of outline effect of objects hidden by frills.",
  component: FeatureColorInputNoMutant,
};
