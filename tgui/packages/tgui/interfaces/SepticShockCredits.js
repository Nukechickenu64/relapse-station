import { useBackend } from "../backend";
import { LabeledList, Section, Stack, BlockQuote, Box } from "../components";
import { Window } from "../layouts";

export const SepticShockCredits = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window
      title="Septic Shock Credits"
      width={450}
      height={700}
      theme="quake">
      <Window.Content>
        <Stack
          height="100%"
          overflowX="hidden"
          overflowY="scroll"
          vertical>
          <Stack.Item>
            <Section title="Developers">
              <LabeledList>
                <LabeledList.Item label="Bomberman66">
                  Host, head coder, boss of this gym
                </LabeledList.Item>
                <LabeledList.Item label="Eve">
                  Co-host, head spriter, touhou lover
                </LabeledList.Item>
                <LabeledList.Item label="Remis12">
                  Co-host, lorebeard, coder, sounder
                </LabeledList.Item>
                <LabeledList.Item label="Redrick">
                  Spriter, kindest man in SS
                </LabeledList.Item>
                <LabeledList.Item label="Admiralwiseguy">
                  Spriter, somalian
                </LabeledList.Item>
                <LabeledList.Item label="Schwick">
                  Spriter, Cruelty Squad enthusiast
                </LabeledList.Item>
                <LabeledList.Item label="Spooky">
                  Spriter, tudo 2
                </LabeledList.Item>
                <LabeledList.Item label="Infrared Baron">
                  Spriter, did most of the turfs, fallout enjoyer
                </LabeledList.Item>
                <LabeledList.Item label="Lordkang45">
                  Writer, lore quality control, only guy in SS who reads books
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Our lovely patrons">
              <LabeledList>
                <LabeledList.Item label="Despy">
                  &quot;why do they call it oven when you
                  of in the cold food of out hot eat the food?&quot;
                </LabeledList.Item>
                <LabeledList.Item label="Reimi">
                  &quot;can i get aheal&quot;
                </LabeledList.Item>
                <LabeledList.Item label="Andrej99">
                  Alan, please add details.
                </LabeledList.Item>
              </LabeledList>
              <BlockQuote mt={3}>
                Not every patron is listed here. <br />
                <Box mt={1.5}>
                  If you have donated to the game and want to be
                  credited, <br />
                  please DM <b>Bomberman66#2148</b> on discord.
                </Box>
                <Box mt={1.5}>
                  Thank you all for the support!
                </Box>
              </BlockQuote>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Special thanks">
              <LabeledList>
                <LabeledList.Item label="/TG/ Station">
                  Providing a base for my code.
                </LabeledList.Item>
                <LabeledList.Item label="Goonstation">
                  Providing several sprites.
                </LabeledList.Item>
                <LabeledList.Item label="CEV Eris">
                  Providing several sprites.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Most special thanks..."
              style={{
                "font-size": "150%",
              }}>
              <LabeledList>
                <LabeledList.Item label="You">
                  For playing here!
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
