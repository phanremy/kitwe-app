import { nodeIds } from 'relatives-tree/utils/units';
import { createFamilyFunc } from 'relatives-tree/parents/create';
import { updateFamilyFunc } from 'relatives-tree/parents/update';
import { arrangeFamiliesFunc } from 'relatives-tree/parents/arrange';

const getParentUnitsWithParents = (family) => (family.parents.filter(unit => (unit.nodes.some(node => !!node.parents.length))));
export const inParentDirection = (store) => {
    const createFamily = createFamilyFunc(store);
    const updateFamily = updateFamilyFunc(store);
    const arrangeFamily = arrangeFamiliesFunc(store);
    let stack = getParentUnitsWithParents(store.rootFamily);
    while (stack.length) {
        const childUnit = stack.pop();
        const family = createFamily(nodeIds(childUnit));
        updateFamily(family, childUnit);
        arrangeFamily(family);
        store.families.set(family.id, family);
        stack = stack.concat(getParentUnitsWithParents(family));
    }
    return store;
};
//# sourceMappingURL=index.js.map
