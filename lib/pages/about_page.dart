import 'package:flutter/material.dart';
import 'package:foast_launcher/localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final double _width = 500;
  final _listDivider = const Divider(height: 1);

  Widget _buildSection(Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: _width,
      child: Card(child: child),
    );
  }

  Widget _buildSubtitle(String text) {
    return Container(
      width: _width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: double.infinity),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
              child: Column(children: [
            _buildSection(Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foast Launcher',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    l10n(context).disclaimerMojang,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )),
            _buildSubtitle('Creators'),
            _buildSection(ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text('TheColdPot'),
                  subtitle: const Text('Main creator'),
                  onTap: () {
                    launch('https://github.com/TheColdPot');
                  },
                ),
                _listDivider,
                ListTile(
                  title: const Text('GitHub contributors'),
                  subtitle: const Text('Supported by community'),
                  onTap: () {
                    launch(
                        'https://github.com/datapack-planet/foast-launcher');
                  },
                ),
              ],
            )),
            _buildSubtitle('Links'),
            _buildSection(ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text('Discord'),
                  subtitle: const Text('Discord server'),
                  onTap: () {
                    launch('https://discord.gg/S6wGBKDXyT');
                  },
                ),
                _listDivider,
                ListTile(
                  title: const Text('GitHub'),
                  subtitle: const Text('The git repository'),
                  onTap: () {
                    launch(
                        'https://github.com/datapack-planet/foast-launcher');
                  },
                ),
                ListTile(
                  title: const Text('Issues'),
                  subtitle: const Text('Submit issues here'),
                  onTap: () {
                    launch(
                        'https://github.com/datapack-planet/foast-launcher/issues');
                  },
                ),
              ],
            )),
            _buildSubtitle('Acknowledgments'),
            _buildSection(ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text('Flutter and its official packages'),
                  subtitle:
                      const Text('The UI framework used by this project'),
                  onTap: () {
                    launch('https://flutter.dev');
                  },
                ),
              ],
            )),
            _buildSubtitle('License'),
            _buildSection(ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text('MIT License'),
                  subtitle: const Text(
                      'This software is open-sourced with an MIT License'),
                  onTap: () {
                    launch(
                        'https://github.com/datapack-planet/foast-launcher/'
                        'blob/main/LICENSE.txt');
                  },
                ),
              ],
            )),
            _buildSubtitle('Disclaimer'),
            _buildSection(Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY '
                'KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE '
                'WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR '
                'PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR '
                'COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR '
                'OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR '
                'OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE '
                'SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ))
          ])),
        )
      ],
    );
  }
}
