import { withType } from 'family-tree/relatives/utils/family';
import { getUnitX, nodeCount } from 'family-tree/relatives/utils/units';
import { inAscOrder,withId } from 'family-tree/relatives/utils/methods';
import { HALF_SIZE, NODES_IN_COUPLE, SIZE } from 'family-tree/relatives/constants';

export const childrenMiddle = (families) => (families
    .filter(withType("root", "child"))
    .reduce((connectors, family) => {
    const parent = family.parents[0];
    const mY = family.Y + (parent ? SIZE : 0);
    family.children.forEach(unit => {
        const left = getUnitX(family, unit) + HALF_SIZE;
        if (nodeCount(unit) === NODES_IN_COUPLE) {
            connectors.push([left, mY + HALF_SIZE, left + SIZE, mY + HALF_SIZE]);
        }
        else if (nodeCount(unit) === 1 && unit.nodes[0].spouses.length) {
            family.children.forEach(nUnit => {
                if (nUnit.nodes.some(withId(unit.nodes[0].spouses[0].id))) {
                    const xX = [left, getUnitX(family, nUnit) + HALF_SIZE].sort(inAscOrder);
                    connectors.push([xX[0], mY + HALF_SIZE, xX[1], mY + HALF_SIZE]);
                }
            });
        }
    });
    return connectors;
}, []));
//# sourceMappingURL=childrenMiddle.js.map
