import 'package:helps_flutter/api/model/announcement_response_model.dart';

class AnnouncementData {
  static List<AnnouncementResponseModel> announcementBufferData = [
    AnnouncementResponseModel(
        v: 0,
        id: "6134baf20ffef75974e05168",
        carBrand: "Chevrolet",
        carModel: "Epica",
        carClass: "Комфорт+",
        manufactoryYear: "2008",
        city: "Питер",
        subway: 'Домодедовская',
        creationDate: DateTime(2024, 12, 1),
        description:
            'Привет, меня зовут Алексей, я сдаю в аренду Chevrolet - Epica 2008 года производства класса Комфорт+. Цена окончательная, все вопросы по телефону.',
        expirationDate: DateTime(2024, 4, 17),
        isActive: true,
        phone: "+7 (123) 456-7890",
        pledge: 30000,
        rentPrice: 1000,
        shouldHighlight: true,
        telegram: 'https://t.me/SmellOfPepper',
        user: "username",
        viewPriority: 0,
        whatsapp: "+7 (123) 456-7890"),
    AnnouncementResponseModel(
        v: 0,
        id: "6134baf20ffef75974e05168",
        carBrand: "Chevrolet",
        carModel: "Epica",
        carClass: "Комфорт+",
        manufactoryYear: "2008",
        city: "Москва",
        subway: 'Домодедовская',
        creationDate: DateTime(2024, 12, 2),
        description:
            'Привет, меня зовут Алексей, я сдаю в аренду Chevrolet - Epica 2008 года производства класса Комфорт+. Цена окончательная, все вопросы по телефону.',
        expirationDate: DateTime(2024, 4, 16),
        isActive: true,
        phone: "+7 (123) 456-7890",
        pledge: 30000,
        rentPrice: 1000,
        shouldHighlight: false,
        telegram: 'https://t.me/SmellOfPepper',
        user: "username",
        viewPriority: 0,
        whatsapp: "+7 (123) 456-7890"),
    AnnouncementResponseModel(
        v: 0,
        id: "6134baf20ffef75974e05168",
        carBrand: "Chevrolet",
        carModel: "Epica",
        carClass: "Комфорт+",
        manufactoryYear: "2008",
        city: "Тюмень",
        subway: 'Домодедовская',
        creationDate: DateTime(2024, 12, 3),
        description:
            'Привет, меня зовут Алексей, я сдаю в аренду Chevrolet - Epica 2008 года производства класса Комфорт+. Цена окончательная, все вопросы по телефону.',
        expirationDate: DateTime(2024, 4, 15),
        isActive: true,
        phone: "+7 (123) 456-7890",
        pledge: 30000,
        rentPrice: 1000,
        shouldHighlight: true,
        telegram: 'https://t.me/SmellOfPepper',
        user: "username",
        viewPriority: 0,
        whatsapp: "+7 (123) 456-7890"),
  ];

  static List<String> carClassList = [
    'Эконом',
    'Комфорт',
    'Комфорт+',
    'Бизнес'
  ];
}
