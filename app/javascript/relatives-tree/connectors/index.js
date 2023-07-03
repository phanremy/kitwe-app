import { parents } from 'relatives-tree/connectors/parents';
import { middle } from 'relatives-tree/connectors/middle';
import { children } from 'relatives-tree/connectors/children';

const toConnectors = (families) => (fn) => fn(families);
export const connectors = (families) => ([parents, middle, children].map(toConnectors(families)).flat());
//# sourceMappingURL=index.js.map
