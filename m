Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3B458AAB
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Nov 2021 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhKVIu4 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 Nov 2021 03:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhKVIuz (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 Nov 2021 03:50:55 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C5C061574
        for <linux-sctp@vger.kernel.org>; Mon, 22 Nov 2021 00:47:49 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so16285084pjb.2
        for <linux-sctp@vger.kernel.org>; Mon, 22 Nov 2021 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KAbhMQt4nCgWni6Pt6IcGkUBR1XzjBlAXekRoPKEnOo=;
        b=jXkX/8xiG2y3badTiE8MKyApgJi7frOSGal5CQRZb4qZVi2SQQTN7Hmxr7jR7LcS0g
         Z9A5CseqQwuX6q+L0LCw8Wl9lpoHSyE6vCNkHMvjNgRhn/jrCDuEglGJ8WRlnDhFkU4F
         U2JkxHyYq4xRcMnhzvWgMcrwPCN2cPYeD2OPx59BKixnOOA8v8ESHYblSgvvtSGBXZeu
         /lDp1Oc6lWHOOYvvzaY2RrzNKlOjwEiDcsTrfbmwkUgqt52GW0naSNx0tSo/fX7YREIZ
         YKo0PAoZGr7+JoQMbvFS//YCIVkDrQB4R8ynEbP//5cRA/UqoeFa2VRdtI4Gi/Z5fILt
         jPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=KAbhMQt4nCgWni6Pt6IcGkUBR1XzjBlAXekRoPKEnOo=;
        b=G+6d3mAMEURI2ZpM+wbnqmj3jecyau7bKj14SrSGdyv7vsm6ico1tnIdKjN2zleyVt
         Q2ZTm770m38s5vO67r+/7qNU1kkSfS3/CogDJCDooN5htaECdntDwSSS5eSAN6SELJ34
         UAlXhoDK/cccX5l37iOP5uSEcWb2KgKZkge6ozcGS2/pFZLgz43H1aPI+AFr0l/dS/j8
         kizCmeZpGMszH8A/2rkQRquiag+iRLVIutZKpKsFphm5fgmVlXlcoAg84jmsNFmQDNSD
         i8P+6hYQKGAz7AhDlwLJMs95zeBc+D78ZwoK509WSSHgmv1fFcmZxKvuLjAKsktDL0lr
         hHkg==
X-Gm-Message-State: AOAM532/gvzjwxrf+kUcF8dlIoF3iNZdRLAmoiFU8YjqiuUm8LAVXHRC
        wYpulv+eSh4dwzAAmybR4zMqZwe6fG0AuPT2VN8=
X-Google-Smtp-Source: ABdhPJyJ3fz+zu1gjA1jqgwSOl2bPwOEe5uIm7znr0ixL9y2mJBY/T8lJHGh5zcB1LVlhbJo4Ey3sfj9ikcVWQvLqDg=
X-Received: by 2002:a17:902:b20b:b0:141:a92c:a958 with SMTP id
 t11-20020a170902b20b00b00141a92ca958mr107166350plr.24.1637570869066; Mon, 22
 Nov 2021 00:47:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90b:4c10:0:0:0:0 with HTTP; Mon, 22 Nov 2021 00:47:48
 -0800 (PST)
Reply-To: justinseydou@gmail.com
From:   Justin Seydou <fredericmoustapha44@gmail.com>
Date:   Mon, 22 Nov 2021 09:47:48 +0100
Message-ID: <CAAH=C4=Mui8+yhPyj=nQt4WMRyDDZMfGLHxoTjhai541UKOcjQ@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Estimado amigo,

Con mucha sinceridad de coraz=C3=B3n les escribo para informarles sobre un =
negocio
propuesta que tengo que me gustar=C3=ADa manejar con ustedes.

Indique amablemente su inter=C3=A9s para habilitar
Yo les doy m=C3=A1s detalles de la propuesta.

Esperando por tu respuesta.

Atentamente,

Se=C3=B1or Justin Seydou.




Dear friend,

With much sincerity of heart I write to inform you about a business
proposal I have which I would like to handle with you.

Kindly indicate your interest so as to enable
me give you more details of the proposal.

Waiting for your response.

Yours faithfully,

Mr.Justin Seydou.
