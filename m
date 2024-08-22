Return-Path: <linux-sctp+bounces-208-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91F95B7D2
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130781F2262A
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39D1C942B;
	Thu, 22 Aug 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f197/uua"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFCBA45;
	Thu, 22 Aug 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335294; cv=none; b=fVU91q1q88OGNwZWCEGsJ2g5R5NcDwX28Xfzo6sEWeLB5I1TY40kQKqZefiovL6XXpjIbvkabmDVLQjxVBrWvsviiTgZu8WakCXZdbpqpP8UlLbWIl9zrS3Q8B86j6rgpW0Jcgw7p/vc/f/OF6nM5lJ78GSW7ZS8bpqFQppPmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335294; c=relaxed/simple;
	bh=x2qPjNuHHPHXUNMZMYf04oPAZSdWZ5gAf5sgm7QhZcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRLHx5hO/LZ+NtNZ9wzW3uOH+Xwg40eki2CMv2tDbqpxVkPq3UjrN+WZMZZivDyPzDF5r9mDEVPwn6vvy0mJbZRjzAZ3I4GSf6F5uXLY8MMuVDP5cF73qPOmrERCzEv0YG0OmuEjLCzFf35UzlDg6quQNjvc5OQvmn2SzLjryps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f197/uua; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81fad534a04so38928339f.1;
        Thu, 22 Aug 2024 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724335292; x=1724940092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2qPjNuHHPHXUNMZMYf04oPAZSdWZ5gAf5sgm7QhZcQ=;
        b=f197/uuaethLqv0GXyMYaug/grkrhEMQI0xknzKcPTsXWAXC6bXVbFJ/Tjqczztkzb
         eIQUitiq2yoSt9I8O6vL0/SnU9q3s4Qoy7sxkyrryh+MgFViyGa5RadlIJpCMxAXbDzv
         ftXJUDGfq1LMLczPNmcdJIKcXnT2Rbadxguscn/uFcXcKl7+Y6gsdoavoxE2OymIC14A
         lmgukWk9/rh8EVi+oCIrLp8A/3icfKcz0s8v2yFbDzbw5sdv41YAfImxYMTI5s7xEUHM
         1NrfbEqH6KTznJ/wh4LP7eseauTt9LNOUuc+Li9e5s7mz2aKnV4L4+jFF+thoR5lotUc
         URng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724335292; x=1724940092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2qPjNuHHPHXUNMZMYf04oPAZSdWZ5gAf5sgm7QhZcQ=;
        b=ny0q3erbxmjVV0qOcIiqjyxOQdSw3OvPLhXZOdRh5fQYbwIwjH9ncBj88fNF6S5WXN
         YkkRetNmI2smImZT0peGM+/yvwdbC37fX1TKiKL7jbcBtSJjhxOjxTpp/kwid5vubHYX
         Wx4XryvIQ14vx5sAnL0Xfhq9r/UZ592BiCgBGJX0poSxzzZ+sWbs5AI6Ov4mg1NjiUmv
         nGhXgdVtWdvtsdO9h/jONXlTz+XRl/o2zFgLkDqoX7aNJkBE0JEE+0u+brhE5UrwxkqL
         9wIh3/Te2gKiztY+M1ImEJ7QJjn0qMjS70o5+zrlCjZlWP5DDXcEW3HEjnHK/Hdx3b6G
         kqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCURCPsDqluYGOsMlZ7/lKLMDC6bAkc+uAWx7RTONfAsOADI3mc7nuNgKJMrfOKpTznhFLsZ6v/K@vger.kernel.org, AJvYcCUVMYVrGoaUyRSpjPYLAyclrjmtXWv90F9rIj5hUxObQQ+ea1wZgcODP/JKt4uLoDkPw8BAiS+MMoCazQ==@vger.kernel.org, AJvYcCWeUCs7Ij4D7SbDgvpA/JeuZLXeuln1S0M/mvl0F5ZGLg6GV1g0IAl/Ot48IvBNyg24bdqaDdy2yQiIuL4L1ziZ4YXMIoQa@vger.kernel.org, AJvYcCWpVUOKnQ9EFW04rbllluYkLWE63jKPQdp/nSGgRPlFjYGtQmYsLFWUJIQFS2IF1Q3mMVr6s3NkeYX9@vger.kernel.org, AJvYcCWtLS+cn+GbL28uNHGq/hjo3oFm333jKUhiVgoDDxfl5qYe4XbWwGi6D7gY3qNkjtS3jTwOkgUk+rC0@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZHWOFAnAsHiHyqbHStbqwfmLtj5M8S6+Fw7Cxh0u2oOHbLZz
	PWxW3Mxth6M7VXt6q7OWNHzo6dw4kqKVuQBvE5FVAzxYGYpV62KGb+oD8ZQ7p0MApuJPs4qkcPj
	NZCWZzqHageKjhX5NlOxc2lmt88g=
X-Google-Smtp-Source: AGHT+IGoHywXfPXWcVCIRs0vbWihS/W/2AVQ9lldOJCBmzFoN+5fr5OfJyfCyckDoTnNZBhPyryQ5p4FlgYMVc8NME8=
X-Received: by 2002:a05:6e02:1807:b0:39d:2ced:e3ee with SMTP id
 e9e14a558f8ab-39d6c378e0emr76394475ab.8.1724335291420; Thu, 22 Aug 2024
 07:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org> <20240822-net-spell-v1-10-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-10-3a98971ce2d2@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 22 Aug 2024 10:01:20 -0400
Message-ID: <CADvbK_f4YQ8gg=w9LygxF-di693HXHhGyH-92e7ofdRPRZDpBg@mail.gmail.com>
Subject: Re: [PATCH net-next 10/13] sctp: Correct spelling in headers
To: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, 
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, Sean Tranchetti <quic_stranche@quicinc.com>, 
	Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Martin Schiller <ms@dev.tdt.de>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:58=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> Correct spelling in sctp.h and structs.h.
> As reported by codespell.
>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: linux-sctp@vger.kernel.org
> Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Xin Long <lucien.xin@gmail.com>

