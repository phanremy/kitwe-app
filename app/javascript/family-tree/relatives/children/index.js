import { withType } from 'family-tree/relatives/utils/family';
import { hasChildren, nodeIds } from 'family-tree/relatives/utils/units';
import { createFamilyFunc } from 'family-tree/relatives/children/create';
import { updateFamilyFunc } from 'family-tree/relatives/children/update';
import { arrangeFamiliesFunc } from 'family-tree/relatives/children/arrange';

const getUnitsWithChildren = (family) => (family.children.filter(hasChildren).reverse());
export const inChildDirection = (store) => {
    const createFamily = createFamilyFunc(store);
    const updateFamily = updateFamilyFunc(store);
    const arrangeFamilies = arrangeFamiliesFunc(store);
    store.familiesArray
        .filter(withType("root"))
        .forEach((rootFamily) => {
        let stack = getUnitsWithChildren(rootFamily);
        while (stack.length) {
            const parentUnit = stack.pop();
            const family = createFamily(nodeIds(parentUnit), "child");
            updateFamily(family, parentUnit);
            arrangeFamilies(family);
            store.families.set(family.id, family);
            stack = stack.concat(getUnitsWithChildren(family));
        }
    });
    return store;
};
//# sourceMappingURL=index.js.map
