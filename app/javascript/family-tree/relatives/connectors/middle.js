import { inAscOrder, withId } from 'family-tree/relatives/utils/methods';
import { getUnitX, nodeCount } from 'family-tree/relatives/utils/units';
import { withType } from 'family-tree/relatives/utils/family';
import { HALF_SIZE, NODES_IN_COUPLE, SIZE } from 'family-tree/relatives/constants';

const calcConnectors = (family, families) => ((connectors, unit) => {
    const pX = getUnitX(family, unit) + HALF_SIZE;
    const pY = family.Y + HALF_SIZE;
    if (nodeCount(unit) === NODES_IN_COUPLE) {
        connectors.push([pX, pY, pX + SIZE, pY]);
    }
    else if (nodeCount(unit) === 1 && unit.nodes[0].spouses.length) {
        families
            .filter(item => item.id !== family.id)
            .forEach(other => {
            other.parents.forEach(parent => {
                if (parent.nodes.some(withId(unit.nodes[0].spouses[0].id))) {
                    const xX = [pX, getUnitX(other, parent) + HALF_SIZE].sort(inAscOrder);
                    connectors.push([xX[0], pY, xX[1], pY]);
                }
            });
        });
    }
    return connectors;
});
export const middle = (families) => {
    const rootFamilies = families.filter(withType("root"));
    return rootFamilies.reduce((connectors, family) => (connectors.concat(family.parents.reduce(calcConnectors(family, rootFamilies), []))), []);
};
//# sourceMappingURL=middle.js.map
