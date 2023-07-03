import { withId, withIds } from './index';
import { nodeIds } from 'relatives-tree/utils/units';

const inUnits = (units, nodeId) => (units.some(unit => unit.nodes.some(withId(nodeId))));
export const hasHiddenRelatives = (family, node) => {
    if (family.type !== "child" && inUnits(family.parents, node.id)) {
        return ((family.type === "parent" && (node.children.length > 1 || node.spouses.length > 1)) ||
            (!node.parents.length && !!node.siblings.length));
    }
    if (family.type !== "parent" && inUnits(family.children, node.id)) {
        const parentIds = family.parents.length ? nodeIds(family.parents[0]) : [];
        return (!node.parents.some(withIds(parentIds)) &&
            (!!node.parents.length || !!node.siblings.length));
    }
    return false;
};
//# sourceMappingURL=hasHiddenRelatives.js.map
