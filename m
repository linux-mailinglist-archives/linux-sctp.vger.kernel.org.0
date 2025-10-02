Return-Path: <linux-sctp+bounces-627-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EFBB500D
	for <lists+linux-sctp@lfdr.de>; Thu, 02 Oct 2025 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBF83B1265
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Oct 2025 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E512286410;
	Thu,  2 Oct 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQLrq3wk"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B1283FCB
	for <linux-sctp@vger.kernel.org>; Thu,  2 Oct 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433259; cv=none; b=o2xWCkoFPFMB1xvEbDYedwo96RrjSJhAcvjYXV1v2CVB6vwDOxqzQOGhG/06qkLOIkYo9GtNnzMHd7l243nbQaGth9k8T7bhFD9+KXQOqVUco/tpWzmFxFnVNQWmnfEUYdfjZHbcGQ8chw/mUHFGNLVx5PCJC1OTgvlHhSvK89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433259; c=relaxed/simple;
	bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSToXcclh+aokPMYv5IFhuHY/htZX0CE29F2d5Invhxizr32ovKzd5lAsJ8sLYt9p//KTJCXdkbIRgD3BhP4Cg1wJ6AtN8y2jc3VWyLLHL4pYGxNCZc/FiAe/ny0Lf8DTegUdySGii5z9iXxuWBvaIbjPcY6dpNKb5ddu7wp8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQLrq3wk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2068007b3a.1
        for <linux-sctp@vger.kernel.org>; Thu, 02 Oct 2025 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759433256; x=1760038056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
        b=hQLrq3wkS1w2Rst7kyCipFyYLo9UtOaIW63nK8eF3rG4SaClFLaBp3htRxxZv0yZ2S
         VcIL/gNs1k4mZ6hTsaLwKjBmuAu1QATVGzeUWM4r29vITo//dGXzY5KK9JPIaqUyxy3v
         lAcmdSQQswBG24pwyRqB4I8kqEv87jMBsdJ/FXks/Ic50py0BVx+b3RJGOH+qK6OFPox
         UW/AjWbCjJuyBQZAQ4KqwEGJE9JDGEvzgeZxL9i91YwSvucnYmepnll0zgCHei07BUj/
         zPoxWGtb/3FYrsC6j+NKmOMwgRg8T2ctNkNlFtvVieuaYvckp3j5zwgFOnYR0LpYCqIF
         F/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433256; x=1760038056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
        b=Xzl4WoSjqfUC7KUiBqkFnoJ7yjcrXZIPTTcUvohEZHSTzGeoP44miX7RBWbE66ucfK
         yfuC46mCDgRsXIYPMlMSW/TlbFIu5ekkk1oup9PSag4YVTyDZvTp+y8L9K/jNec/CL3u
         uS6dHnTVoeWM47s5SpUYjpDlyD2Bv3EuNsvDM5pRo1RyzXa46R/9WWqw48YExmhMMzw9
         0HHzBeWAXZ7MEbBrjKxE4pGtGDA+lnYNYJ6A77V9zVk37SaojVILSDavc9zxqFutygbb
         9wF70t20G9bdLgd/oKKGmSul5zwMKMZe2q+UWxFR4SEEMLNwLX9OQmwiGe/0vlSdhBR4
         hwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaRMOGCHseTmkX0jdl9mWnwBH+JbZXLQfnF9N0Oxo5NkGWf7t8qxWd1PbdAC28W/sw8KqWlycnL/p7@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8PLSHkxAv4XEXN/SbjFFFN/MFWi8SeT8CY8qogXtmu08Z2A0
	O9HV/oBGmpva9SnC/cPy5lwdPosGUDE6MmWZKN4+PxHhZ2WIn0rXimAGCSSRwTS4jjeswK3f2Cw
	niBNeEiuN9/zh2Cz9ITc1mIolaG38Pss=
X-Gm-Gg: ASbGncsSSX8Y2rs1dY/qkkAWd1B2sph4D3jXOkJCRhgoT5MTjoRBa5RGdXlXoS1tJGh
	77SP3QRiDrzzTA0OYovulhf3SkVHpe6vPhJ0aeBWlJWfR770lgXUoE1nzVzXCA2rb7FCuaQwl7+
	Ejwsn/dIui0erjUuGSMAGqjJs4rawTFXj5XFemW9u76MLfo9Jxa3GgLkmrGpsYxzR7rU79xuaw/
	BrADKQ0mkKSYAYLr/0wCbsO62plZbVJLhucgE1phMTDL3U6Is0Do04q4lGvaQM3dA==
X-Google-Smtp-Source: AGHT+IFHSMffOMVezAKpxf4xflxQPXHC/9PQfQy6n4Qt8MWkSRyYgaxLIW31hWZlX2OEAHUKUARWDCpbLDiVfKNbRN0=
X-Received: by 2002:a05:6a20:9389:b0:243:b62c:8a7d with SMTP id
 adf61e73a8af0-32b6175aafbmr953767637.0.1759433256415; Thu, 02 Oct 2025
 12:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002091448.11-1-alsp705@gmail.com>
In-Reply-To: <20251002091448.11-1-alsp705@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 2 Oct 2025 15:27:25 -0400
X-Gm-Features: AS18NWBJ2McJoGNd_MZw_c2oTY1FRFEzCn1b6DwesYnkNNElFy-oHlpyddLBacw
Message-ID: <CADvbK_frvOEC4-UbuYixCu2RbQuAOQLmTsi5-sGnO8_+ZSpT8A@mail.gmail.com>
Subject: Re: [PATCH] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 5:14=E2=80=AFAM Alexandr Sapozhnkiov <alsp705@gmail.=
com> wrote:
>
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>
> If new_asoc->peer.adaptation_ind=3D0 and sctp_ulpevent_make_authkey=3D0
> and sctp_ulpevent_make_authkey() returns 0, then the variable
> ai_ev remains zero and the zero will be dereferenced
> in the sctp_ulpevent_free() function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for
AUTHENTICATION_EVENT")

Acked-by: Xin Long <lucien.xin@gmail.com>

