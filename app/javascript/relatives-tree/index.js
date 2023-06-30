import Store from 'relatives-tree/store';
import { placeholders } from 'relatives-tree/middle/placeholders';
import { inMiddleDirection } from 'relatives-tree/middle';
import { inParentDirection } from 'relatives-tree/parents';
import { inChildDirection } from 'relatives-tree/children';
import { connectors } from 'relatives-tree/connectors';
import { correctPositions } from 'relatives-tree/utils/correctPositions';
import { getCanvasSize } from 'relatives-tree/utils/getCanvasSize';
import { getExtendedNodes } from 'relatives-tree/utils/getExtendedNodes';
import { pipe } from 'relatives-tree/utils';

const calcFamilies = pipe(inMiddleDirection, inParentDirection, inChildDirection, correctPositions);
export default (nodes, options) => {
    const store = new Store(nodes, options.rootId);
    if (options.placeholders)
        placeholders(store);
    const families = calcFamilies(store).familiesArray;
    return {
        families: families,
        canvas: getCanvasSize(families),
        nodes: getExtendedNodes(families),
        connectors: connectors(families),
    };
};
//# sourceMappingURL=index.js.map
