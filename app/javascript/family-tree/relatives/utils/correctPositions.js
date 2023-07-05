import { min, prop } from 'family-tree/relatives/utils/methods';
import { withType } from 'family-tree/relatives/utils/family';
import { getUnitX } from 'family-tree/relatives/utils/units';

const alignGenerations = (families, root) => {
    const parents = families.find(family => family.cid === root.id);
    if (parents) {
        const shift = (getUnitX(parents, parents.children[0]) -
            getUnitX(root, root.parents[0]));
        families
            .filter(withType("child", "root"))
            .forEach(family => family.X += shift);
    }
};
const correct = (families, coordinate) => {
    const shift = min(families.map(prop(coordinate))) * -1;
    if (shift !== 0)
        families.forEach(family => family[coordinate] += shift);
};
export const correctPositions = (store) => {
    const families = store.familiesArray;
    alignGenerations(families, store.rootFamily);
    correct(families, 'Y');
    correct(families, 'X');
    return store;
};
//# sourceMappingURL=correctPositions.js.map
