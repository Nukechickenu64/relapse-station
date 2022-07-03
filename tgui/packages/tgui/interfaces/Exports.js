import { useBackend } from "../backend";
import { Icon, Section, Table, Box } from '../components';
import { Window } from '../layouts';

export const Exports = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    exports = [],
  } = data;

  return (
    <Window
      title="Exports Console"
      width={600}
      height={750}>
      <Window.Content scrollable>
        <Section title="Exports">
          <Table>
            <Table.Row
              className="Table__row"
              style={{
                'background-color': 'rgb(255, 255, 152, 1)',
              }}
              verticalAlign="middle"
              header>
              <Table.Cell collapsing textAlign="left">
                Name
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                Previous Value
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                Value
              </Table.Cell>
            </Table.Row>
            {exports.map(stonk => (
              <Table.Row
                key={stonk.unit_name}
                className="Table__row candystripe"
                textAlign="center"
              >
                <Table.Cell collapsing textAlign="left">
                  {stonk.unit_name}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  <Box
                    inline
                    color="grey"
                  >
                    {stonk.previous_cost}
                  </Box>
                </Table.Cell>
                <Table.Cell collapsing textAlign="right">
                  <Icon
                    name={stonk.cost > stonk.previous_cost
                      ? "caret-up" : (stonk.cost < stonk.previous_cost
                        ? "caret-down" : "minus")}
                    color={stonk.cost > stonk.previous_cost
                      ? "green" : (stonk.cost < stonk.previous_cost
                        ? "red" : "grey")}
                    mr={0.5}
                  />
                  <Box
                    inline
                    color={stonk.cost > stonk.previous_cost
                      ? "green" : (stonk.cost < stonk.previous_cost
                        ? "red" : "grey")}
                  >
                    {stonk.cost}
                  </Box>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
