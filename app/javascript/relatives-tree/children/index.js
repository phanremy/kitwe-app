import { withType } from 'relatives-tree/utils/family';
import { hasChildren, nodeIds } from 'relatives-tree/utils/units';
import { createFamilyFunc } from 'relatives-tree/children/create';
import { updateFamilyFunc } from 'relatives-tree/children/update';
import { arrangeFamiliesFunc } from 'relatives-tree/children/arrange';

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
