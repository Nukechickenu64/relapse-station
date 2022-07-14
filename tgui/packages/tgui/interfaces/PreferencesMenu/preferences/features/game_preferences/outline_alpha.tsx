import { Feature, FeatureNumberInput } from "../base";

export const outline_alpha: Feature<number> = {
  name: "Outline alpha",
  category: "UI",
  description: "Alpha of outline effect of objects hidden by frills.",
  component: FeatureNumberInput,
};
