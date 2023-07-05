import { hasDiffParents } from 'family-tree/relatives/utils/methods';
import { rightOf } from 'family-tree/relatives/utils/family';
import { createBloodFamilies, createDiffTypeFamilies, createFamilyWithoutParents } from 'family-tree/relatives/middle/create';

const arrangeFamilies = (families) => {
    for (let i = 1; i < families.length; i++) {
        families[i].X = rightOf(families[i - 1]);
    }
};
export const inMiddleDirection = (store) => {
    const families = store.root.parents.length
        ? (hasDiffParents(store.root))
            ? createDiffTypeFamilies(store)
            : createBloodFamilies(store)
        : createFamilyWithoutParents(store);
    arrangeFamilies(families);
    families.forEach(family => store.families.set(family.id, family));
    return store;
};
//# sourceMappingURL=index.js.map
