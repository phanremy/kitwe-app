import { getUnitX } from './units';
import { hasHiddenRelatives } from './hasHiddenRelatives';
import { SIZE } from '../constants';
const extendNode = (family) => ((unit) => (unit.nodes.map((node, idx) => ({
    ...node,
    top: family.Y + (unit.child && !!family.parents.length ? SIZE : 0),
    left: getUnitX(family, unit) + (idx * SIZE),
    hasSubTree: hasHiddenRelatives(family, node),
}))));
const getParentNodes = (family) => (["root", "parent"].includes(family.type) ? family.parents : []).map(extendNode(family));
const getChildNodes = (family) => (["root", "child"].includes(family.type) ? family.children : []).map(extendNode(family));
const mapFamily = (family) => [getParentNodes(family), getChildNodes(family)].flat(2);
export const getExtendedNodes = (families) => families.map(mapFamily).flat();
//# sourceMappingURL=getExtendedNodes.js.map