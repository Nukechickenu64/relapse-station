import { Species } from "./base";

const Shibu: Species = {
  description: "The Shibu are natives to Nevado, most resembling old Earth canines.",
  features: {
    good: [],
    neutral: [{
      icon: "fist-raised",
      name: "Natural-born Warrior",
      description: "Due to the harshness of the pre ice age tropical forests, and \
      post ice age wasteland, Shibu society favors strength over mental acuity.",
    }],
    bad: [],
  },
  lore: [
    "Steadfast, devout and loyal. These are the qualities that define the Shibu.",
    "Once on the brink in a world of collapsing tradition and ever more bitter conditions,",
    "the Shibu through loyalty to ZoomTech have helped transform Nevado and plan to bring it ever forward",
    "into a new golden age under the guidance of their elders.",
  ],
};

export default Shibu;
