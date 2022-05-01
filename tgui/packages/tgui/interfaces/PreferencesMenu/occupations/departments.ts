export type Department = {
  head?: string;
};

export const Beggar: Department = {
  // "Beggar" is not the head of its own department, as otherwise
  // it would show as large and bold.
};

export const Nobility: Department = {
  head: "Mayor",
};

export const Bourgeouis: Department = {
  head: "Merchant",
};

export const Proletariat: Department = {
};

export const Unpeople: Department = {
  head: "Beggar",
};
