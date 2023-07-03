import { createChildUnitsFunc } from '../utils/createChildUnitsFunc';
import { createFamilyFunc } from '../children/create';
import { getSpouseNodesFunc } from '../utils/getSpouseNodesFunc';
import { setDefaultUnitShift } from '../utils/setDefaultUnitShift';
import { prop, withRelType } from '../utils';
import { newFamily } from '../utils/family';
import { unitsToNodes } from '../utils/units';
import { NODES_IN_COUPLE } from '../constants';
import { correctOverlaps } from './correctOverlaps';
export const createFamilyWithoutParents = (store) => {
    const family = newFamily(store.getNextId(), "root", true);
    family.children = createChildUnitsFunc(store)(family.id, store.root);
    setDefaultUnitShift(family);
    return [family];
};
const getParentIDs = (root, type) => (root.parents.filter(withRelType(type)).map(prop('id')));
export const createDiffTypeFamilies = (store) => {
    const createFamily = createFamilyFunc(store);
    const bloodFamily = createFamily(getParentIDs(store.root, "blood"), "root", true);
    const adoptedFamily = createFamily(getParentIDs(store.root, "adopted"));
    correctOverlaps(bloodFamily, adoptedFamily);
    return [bloodFamily, adoptedFamily];
};
export const createBloodFamilies = (store) => {
    const createFamily = createFamilyFunc(store);
    const mainFamily = createFamily(store.root.parents.map(prop('id')), "root", true);
    const parents = unitsToNodes(mainFamily.parents);
    if (parents.length === NODES_IN_COUPLE) {
        const { left, right } = getSpouseNodesFunc(store)(parents);
        return [
            left.map(node => createFamily([node.id])),
            mainFamily,
            right.map(node => createFamily([node.id])),
        ].flat();
    }
    return [mainFamily];
};
//# sourceMappingURL=create.js.map