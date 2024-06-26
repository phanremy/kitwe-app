import { SIZE } from 'family-tree/relatives/constants';
import { prop } from 'family-tree/relatives/utils/methods';

// fid: family id
export const newUnit = (fid, nodes, isChild = false) => ({
    fid,
    child: isChild,
    nodes: [...nodes],
    pos: 0,
});
export const nodeIds = (unit) => unit.nodes.map(prop('id'));
export const nodeCount = (unit) => unit.nodes.length;
export const hasChildren = (unit) => unit.nodes.some(node => node.children.length);
export const rightSide = (unit) => unit.pos + nodeCount(unit) * SIZE;
// export const sameAs = (target) => (unit) => {
//   console.log('target', target)
//   console.log('unit', unit)
//   console.log('nodeIds(target).join(\'\')', nodeIds(target).join(''))
//   console.log('nodeIds(unit).join(\'\')', nodeIds(unit).join(''))
//   nodeIds(target).join('') === nodeIds(unit).join('')
// };
export const sameAs = (target) => (unit) => nodeIds(target).join('') === nodeIds(unit).join('');
export const getUnitX = (family, unit) => family.X + unit.pos;
export const unitsToNodes = (units) => units.map(prop('nodes')).flat();
export const arrangeInOrder = (units) => {
    units.forEach((unit, idx, self) => (unit.pos = idx === 0 ? 0 : rightSide(self[idx - 1])));
};
export const correctUnitsShift = (units, shift) => (units.forEach((unit) => unit.pos += shift));
//# sourceMappingURL=units.js.map
