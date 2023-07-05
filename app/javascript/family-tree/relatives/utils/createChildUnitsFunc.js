import { getSpouseNodesFunc } from 'family-tree/relatives/utils/getSpouseNodesFunc';
import { newUnit } from 'family-tree/relatives/utils/units';

const toArray = (nodes) => nodes.map(node => Array.of(node));
export const createChildUnitsFunc = (store) => {
    const getSpouseNodes = getSpouseNodesFunc(store);
    return (familyId, child) => {
        const { left, middle, right } = getSpouseNodes([child]);
        return [...toArray(left), middle, ...toArray(right)]
            .map((nodes) => newUnit(familyId, nodes, true));
    };
};
//# sourceMappingURL=createChildUnitsFunc.js.map
