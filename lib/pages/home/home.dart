import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:orquideas_chilpancingo/pages/home/header_place.dart';
import 'package:orquideas_chilpancingo/providers/badge_provider.dart';
import 'package:orquideas_chilpancingo/providers/models/orquideas_model.dart';
import 'package:orquideas_chilpancingo/utils/storage/storage.dart';
import 'package:orquideas_chilpancingo/widgets/headers/sliverheader.dart';
import 'package:orquideas_chilpancingo/widgets/inputs/input.dart';
import 'package:provider/provider.dart';
import '../../services/dio_errors.dart';
import '../../widgets/cards/card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _buscar = TextEditingController();
  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1);
  Map<String, dynamic> newitems = {};
  List<Map<String, dynamic>> length = [];
  late Future carritoFuture;
  @override
  void initState() {
    carritoFuture = _dataFuture();
    _pagingController.addPageRequestListener((pageKey) {
      if (mounted) _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: carritoFuture,
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Map> query = snapshot.data;
          int carrito = query[0]["total"] ?? 0;
          WidgetsBinding.instance?.addPostFrameCallback((value) {
            Provider.of<BadgeProvider>(context, listen: false).carBadge =
                carrito;
          });
        }
        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                floating: true,
                delegate: SliverCustomHeaderDelegate(
                    minHeight: MediaQuery.of(context).viewPadding.top + 110,
                    maxHeight: MediaQuery.of(context).viewPadding.top + 150,
                    child: const HeaderLogo())),
            SliverToBoxAdapter(
              child: InputDesing(
                icon: Icons.search_outlined,
                textdescription: "Buscar",
                height: 39,
                width: 393,
                readOnly: false,
                controller: _buscar,
                type: TextInputType.text,
              ),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 15,
            )),
            PagedSliverGrid(
                pagingController: _pagingController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 4.6 / 4.6),
                builderDelegate:
                    PagedChildBuilderDelegate<Map<String, dynamic>>(
                        itemBuilder: (context, data, index) {
                  return CardDesing(
                    orquidea: data,
                  );
                }))
          ],
        );
      }),
    );
  }

  //fetch
  Future<void> _fetchPage(int pageKey) async {
    List<Map<String, dynamic>> items = [];
    if (mounted) {
      try {
        await Provider.of<OrquideasProvider>(context, listen: false)
            .getOrquideas(context, pageKey);

        items =
            Provider.of<OrquideasProvider>(context, listen: false).orquideas;

        int totaldocs =
            Provider.of<OrquideasProvider>(context, listen: false).totaldocs;

        final previouslyFetchedItemsCount =
            _pagingController.itemList?.length ?? 0;

        bool isLastPage = previouslyFetchedItemsCount == totaldocs;

        if (isLastPage) {
          _pagingController.appendLastPage(items);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(items, nextPageKey);
        }
      } on DioError catch (error) {
        if (mounted) {
          handleError(error, context);
          _pagingController.error = error;
        }
      }
    }
  }

  Future<List<Map>> _dataFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    return await StorageTables().getTotalCart();
  }
}
